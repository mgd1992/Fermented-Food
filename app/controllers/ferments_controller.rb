class FermentsController < ApplicationController
  before_action :set_user, only: [:new, :create, :edit, :update]
  before_action :set_ferment, only: [:show, :edit, :update, :destroy, :destroy_photo]
  before_action :authorize_user!, only: [:new, :create, :edit, :update, :destroy, :destroy_photo]

  def index
    ferments = Ferment.order(created_at: :desc)
                      .includes(:comments, photos_attachments: :blob, user: { photo_attachment: :blob })

    if params[:query].present?
      query = "%#{params[:query]}%"
      ferments = ferments.where("name ILIKE :q OR ingredients ILIKE :q", q: query)
    end

    case params[:status]
    when "ready"
      ferments = ferments.where("review_date <= ?", Date.today)
    when "active"
      ferments = ferments.where("review_date > ?", Date.today)
    end

    @ferments = ferments.page(params[:page]).per(10).load_async
  end

  def show
    @comments = @ferment.comments.includes(:user)
    @comment = Comment.new
  end

  def new
    @ferment = Ferment.new
    session[:return_to] = request.referer unless request.referer&.include?('new')
  end

  def create
    @ferment = current_user.ferments.build(ferment_params)

    respond_to do |format|
      if @ferment.save
        format.html { redirect_to @ferment, status: :see_other, notice: "Fermento creado con éxito " }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("ferment_form", partial: "form", locals: { ferment: @ferment }) }
      end
    end
  end

  def edit
  end

  def update
    if @ferment.update(ferment_params.except(:photos))
      attach_photos_if_present
      respond_to do |format|
        format.html { redirect_to ferment_path(@ferment), notice: "Fermento actualizado con éxito " }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("ferment_form", partial: "form", locals: { ferment: @ferment }) }
      end
    end
  end

  def restart
    @ferment = Ferment.find(params[:id])
    if @ferment.user == current_user
      if @ferment.update(start_date: Date.today)
        redirect_to ferment_path(@ferment), notice: "¡Ciclo reiniciado! El fermento vuelve a contar desde hoy."
      else
        redirect_to ferment_path(@ferment), alert: "No se pudo reiniciar el fermento."
      end
    else
      redirect_to root_path, alert: "No tienes permiso para realizar esta acción."
    end
  end

  def destroy
    if @ferment.user == current_user
      @ferment.destroy!
      respond_to do |format|
        format.html { redirect_to profile_path(current_user), notice: "Fermento eliminado con éxito " }
        format.turbo_stream
      end
    else
      redirect_to ferments_path, alert: "No tienes permiso para eliminar este fermento "
    end
  end

  def destroy_photo
    photo = @ferment.photos.find(params[:photo_id])
    photo.purge_later

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(helpers.dom_id(photo)),
          (@ferment.photos.reload.empty? ?
            turbo_stream.update("photos-container-#{@ferment.id}", render_to_string(partial: 'ferments/empty_photos')) :
            nil)
        ].compact
      end
      format.html { redirect_to @ferment }
    end
  end

  private

  def set_user
    @user = current_user
  end

  def set_ferment
    @ferment = Ferment.includes(:user, photos_attachments: :blob, comments: []).find(params[:id])
  end

  def ferment_params
    params.require(:ferment).permit(
      :name, :description, :instructions, :ingredients,
      :fermentation_time, :start_date, :revisar_fermentos, photos: []
    )
  end

  def authorize_user!
    if @ferment.present?
      unless @ferment.user == current_user
        redirect_to root_path, alert: "No tienes permiso"
      end
    else
      unless user_signed_in?
        redirect_to new_user_session_path, alert: "Debes iniciar sesión"
      end
    end
  end

  def attach_photos_if_present
    return unless params[:ferment][:photos].present?
    photos_to_attach = params[:ferment][:photos].reject(&:blank?)
    @ferment.photos.attach(photos_to_attach) if photos_to_attach.any?
  end

  def schedule_review_job
    return unless @ferment.start_date && @ferment.revisar_fermentos
    review_date = @ferment.start_date + @ferment.revisar_fermentos.days
    ReviewReminderJob.set(wait_until: review_date).perform_later(@ferment.id)
  end
end
