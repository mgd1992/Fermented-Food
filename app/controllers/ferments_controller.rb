class FermentsController < ApplicationController
  def index
    @ferments = Ferment.includes(:user).all
  end

  def show
    @ferment = Ferment.find(params[:id])
  end

  def new
    @ferment = Ferment.new
  end

  def create
    @ferment = Ferment.new(ferment_params)

    if @ferment.save!
      redirect_to @ferment, notice: 'Ferment was successfully created.'
    else
      render :new
    end
  end

  def edit
    @ferment = Ferment.find(params[:id])
  end

  def update
    if @ferment.update(ferment_params)
      redirect_to @ferment, notice: 'Ferment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @ferment = Ferment.find(params[:id])
    @ferment.destroy
    raise
    redirect_to @ferments, notice: 'Ferment was successfully destroyed.'
  end

  private

  def ferment_params
    params.require(:ferment).permit(:name, :description, :user_id)
  end
end
