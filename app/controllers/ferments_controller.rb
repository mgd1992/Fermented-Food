class FermentsController < ApplicationController
  require 'meilisearch'
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_ferment, only: [:show, :edit, :update, :destroy]


  def index
    @ferments = Ferment.search(params[:query]).page(params[:page]).per(5)

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
      render :edit, alert: "No se pudo actualizar el fermento."
    end
  end

  def destroy
    if @ferment.user == current_user
      @ferment.destroy
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
    params.require(:ferment).permit(:name, :instructions, :user_id, :ingredients, :fermentation_time, photos: [])
  end
end
