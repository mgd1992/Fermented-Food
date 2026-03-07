class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ferment

  def create
    @like = @ferment.likes.build(user: current_user)
    if @like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back fallback_location: ferment_path(@ferment) }
      end
    else
      redirect_back fallback_location: ferment_path(@ferment)
    end
  end

  def destroy
    @like = @ferment.likes.find_by(user: current_user)
    @like&.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: ferment_path(@ferment) }
    end
  end

  private

  def set_ferment
    @ferment = Ferment.find(params[:ferment_id])
  end
end
