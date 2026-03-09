class FermentsController < ApplicationController
  before_action :set_user, only: %i[new create edit update]
  before_action :set_ferment, only: %i[show edit update destroy destroy_photo restart]
  before_action :authenticate_user!, only: %i[new create edit update destroy destroy_photo restart]
  before_action :authorize_ferment!, only: %i[edit update destroy destroy_photo restart]

  def index
    ferments = Ferment.order(created_at: :desc)
                      .includes(:comments, photos_attachments: :blob, user: { photo_attachment: :blob })

    ferments = ferments.search_by_details(params[:query]) if params[:query].present?

    case params[:status]
    when "ready"
      ferments = ferments.where(review_date: ..Time.zone.today)
    when "active"
      ferments = ferments.where("review_date > ?", Time.zone.today)
    end

    @ferments = ferments.page(params[:page]).per(10).load_async
  end

  def show
    @photos_by_day = @ferment.photos.group_by { |p| p.created_at.to_date }.sort.to_h
    @comments = @ferment.comments.includes(:user)
    @comment = Comment.new
  end

  def new
    @ferment = Ferment.new
    session[:return_to] = request.referer unless request.referer&.include?('new')
  end

  def edit
  end

  def create
    @ferment = current_user.ferments.build(ferment_params)

    respond_to do |format|
      if @ferment.save
        schedule_review_job
        format.html { redirect_to @ferment, status: :see_other, notice: "Fermento creado con éxito " }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("ferment_form", partial: "form", locals: { ferment: @ferment })
        end
      end
    end
  end

  def update
    if @ferment.update(ferment_params.except(:photos))
      attach_photos_if_present
      schedule_review_job
      respond_to do |format|
        format.html { redirect_to ferment_path(@ferment), notice: "Fermento actualizado con éxito " }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("ferment_form", partial: "form", locals: { ferment: @ferment })
        end
      end
    end
  end

  def restart
    @ferment = Ferment.find(params[:id])
    authorize @ferment
    if @ferment.update(start_date: Time.zone.today)
      redirect_to ferment_path(@ferment), notice: "¡Ciclo reiniciado!"
    else
      redirect_to ferment_path(@ferment), alert: "No se pudo reiniciar el fermento."
    end
  end

  def destroy
    @ferment.destroy!
    respond_to do |format|
      format.html { redirect_to profile_path(current_user), notice: "Fermento eliminado con éxito" }
      format.turbo_stream
    end
  end

  def destroy_photo
    photo = @ferment.photos.find(params[:photo_id])
    photo.purge_later

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(helpers.dom_id(photo)),
          (if @ferment.photos.reload.empty?
             turbo_stream.update("photos-container-#{@ferment.id}", render_to_string(partial: 'ferments/empty_photos'))
           end)
        ].compact
      end
      format.html { redirect_to @ferment }
    end
  end

  def public
    @ferment = Ferment.find_by!(share_token: params[:share_token])
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
      redirect_to root_path, alert: "No tienes permiso" unless @ferment.user == current_user
    else
      redirect_to new_user_session_path, alert: "Debes iniciar sesión" unless user_signed_in?
    end
  end

  def authorize_ferment!
    authorize @ferment
  end

  def attach_photos_if_present
    return if params[:ferment][:photos].blank?

    photos_to_attach = params[:ferment][:photos].compact_blank
    @ferment.photos.attach(photos_to_attach) if photos_to_attach.any?
  end

  def schedule_review_job
    return unless @ferment.start_date && @ferment.revisar_fermentos

    review_date = @ferment.start_date + @ferment.revisar_fermentos.days
    ReviewReminderJob.set(wait_until: review_date).perform_later(@ferment.id)
  end
end
