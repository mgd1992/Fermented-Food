class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @ferments = @user.ferments.includes(:user, :comments, photos_attachments: :blob).with_attached_photos
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
    if params[:user][:password].present?
      if @user.update_with_password(user_params)
        bypass_sign_in(@user)
        redirect_to user_path(@user), notice: "Perfil y contraseña actualizados"
      else
        render :edit
      end
    else
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
      params[:user].delete(:current_password)
      if @user.update(user_params)
        redirect_to user_path(@user), notice: "Perfil actualizado"
      else
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :photo)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path, alert: "Usuario no encontrado" unless @user
  end
end
