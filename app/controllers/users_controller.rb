class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @user = User.includes(ferments: { photos_attachments: :blob }).find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end

    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Perfil actualizado'
    else
      render :edit
    end

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :photo)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path, alert: "Usuario no encontrado" unless @user
  end
end
