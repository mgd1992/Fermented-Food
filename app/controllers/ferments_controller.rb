class FermentsController < ApplicationController
  before_action :set_ferment, only: [:show, :edit, :update, :destroy]

  def index
    @ferments = Ferment.includes(:user).all

    if params[:query].present?
      @ferments = Ferment.where("name ILIKE ?", "%#{params[:query]}%")
    end

  end

  def show
  end

  def new
    @ferment = Ferment.new
  end

  def create
    @ferment = Ferment.new(ferment_params)
    @ferment.user = current_user
    if @ferment.save!
      redirect_to @ferment, notice: 'You ferment was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @ferment = Ferment.find(params[:id])

    nuevas_fotos = params[:ferment][:photos] if params[:ferment][:photos].present?

    nuevas_fotos.each { |foto| @ferment.photos.attach(foto) } if nuevas_fotos.present?

    if @ferment.update(ferment_params.except(:photos))
      redirect_to @ferment, notice: 'Your ferment was successfully updated.'
    else
      render :edit
    end
  end


  def destroy

    #if @ferment.user == current_user
      @ferment.destroy
      redirect_to ferments_path, notice: 'Your ferment was successfully destroyed.'
    #end
  end

  private

  def set_ferment
    @ferment = Ferment.find(params[:id])
  end

  def ferment_params
    params.require(:ferment).permit(:name, :description, :user_id, photos: [])
  end
end
