class FermentsController < ApplicationController
  before_action :set_ferment, only: [:show, :edit, :update, :destroy, :destroy_photo]
  before_action :authorize_user!, only: [:destroy, :destroy_photo]

  def index
    if params[:query].present?
      query = "%#{params[:query]}%"
      @ferments = Ferment
        .where("name ILIKE :q OR ingredients ILIKE :q", q: query)
        .order(created_at: :desc)
        .page(params[:page])
        .per(10)
    else
      @ferments = Ferment
        .order(created_at: :desc)
        .page(params[:page])
        .per(10)
    end
  end

  def show
    @comments = @ferment.comments.includes(:user)
    @comment = Comment.new
  end

  def new
    @ferment = Ferment.new
  end

  def create
    @ferment = Ferment.new(ferment_params)
    @ferment.user = current_user

    if @ferment.save
      review_date = @ferment.start_date + @ferment.revisar_fermentos.days
      ReviewReminderJob.set(wait_until: review_date).perform_later(@ferment.id)

      redirect_to @ferment, notice: "Fermento creado con éxito."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ferment.update(ferment_params)
      redirect_to @ferment, notice: "Fermento actualizado con éxito."
    else
      render :edit, alert: "No se pudo actualizar el fermento."
    end
  end

  def destroy
    if @ferment.user == current_user
      @ferment.destroy!
      redirect_to @ferment.user, notice: "Fermento eliminado con éxito."
    else
      redirect_to ferments_path, alert: "No tienes permiso para eliminar este fermento."
    end
  end

  # Eliminar fotos
  def destroy_photo
    photo = @ferment.photos.find(params[:photo_id])
    photo.purge

    redirect_to ferment_path(@ferment), notice: "Foto eliminada con éxito."
  end

  private

  def set_ferment
    @ferment = Ferment.includes(:user, photos_attachments: :blob, comments: []).find(params[:id])
  end

  # ✅ Campos permitidos para create
  def ferment_params
    params.require(:ferment).permit(
      :name, :instructions, :ingredients, :fermentation_time,
      :start_date, :description ,:revisar_fermentos, photos: []
    )
  end

  # ✅ Campos permitidos para update (sin fotos)
  def ferment_params_except_photos
    params.require(:ferment).permit(
      :name, :instructions, :ingredients, :fermentation_time,
      :start_date, :revisar_fermentos
    )
  end

  def authorize_user!
    redirect_to ferments_path, alert: "No tienes permiso" unless @ferment.user == current_user
  end
end
