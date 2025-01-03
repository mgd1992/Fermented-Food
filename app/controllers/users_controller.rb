class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #sign_in(:user, @user)
      redirect_to user_path(@user) # Redirect to the user's profile page
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :photo)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
