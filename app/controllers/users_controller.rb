class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  before_action :set_user, only: %i[show edit update]

  def show
    @ferments = @user.ferments.includes(:user, :comments, photos_attachments: :blob).with_attached_photos
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def update
    if params[:user][:password].present?
      update_with_password
    else
      update_without_password
    end
  end

  private

  def update_with_password
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      redirect_to user_path(@user), notice: "Perfil y contraseña actualizados"
    else
      render :edit
    end
  end

  def update_without_password
    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
    params[:user].delete(:current_password)
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Perfil actualizado"
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password,
                                 :photo)
  end

  def set_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path, alert: "Usuario no encontrado" unless @user
  end
end
