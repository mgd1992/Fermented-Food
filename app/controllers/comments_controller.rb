class CommentsController < ApplicationController
  before_action :set_ferment

  def create
    @comment = @ferment.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @ferment, notice: 'Comentario creado con éxito.'
    else
      redirect_to @ferment, alert: 'Hubo un problema al crear el comentario.'
    end
  end

  def destroy
    if @user == current_user
      @comment.destroy!
      redirect_to @ferment.comments
    end
  end


private

  def set_ferment
    @ferment = Ferment.find(params[:ferment_id])
  end

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
