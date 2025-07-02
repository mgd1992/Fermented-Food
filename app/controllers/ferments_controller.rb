class FermentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :edit]
  before_action :set_ferment, only: [:show, :edit, :update, :destroy]


  def index
    if params[:query].present?
      query = "%#{params[:query]}%"
      @ferments = Ferment.where("name ILIKE :q OR ingredients ILIKE :q OR instructions ILIKE :q", q: query)
                        .order(created_at: :desc)
                        .page(params[:page])
    else
      @ferments = Ferment.order(created_at: :desc).page(params[:page])
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
      redirect_to ferments_path, notice: "Fermento creado con éxito."
    else
      render :new, alert: "No se pudo crear el fermento."
    end
  end

  def edit
  end

  def update
    if @ferment.update(ferment_params)
      redirect_to ferments_path, notice: "Fermento actualizado con éxito."
    else
      puts @ferment.errors.full_messages
      render :edit, alert: "No se pudo actualizar el fermento."
    end
  end

  def destroy
    if @ferment.user_id == current_user.id
      @ferment.destroy!
      redirect_to ferments_path, notice: "Fermento eliminado con éxito."
    else
      redirect_to ferments_path, alert: "No tienes permiso para eliminar este fermento."
    end
  end

  private

  def set_ferment
    @ferment = Ferment.find(params[:id])
  end

  def ferment_params
    params.require(:ferment).permit(:name, :instructions, :user_id, :ingredients, :fermentation_time, :start_date, photos: [])
  end
end
