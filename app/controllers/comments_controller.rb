class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ferment
  before_action :set_comment, only: [:destroy]
  before_action :authorize_user!, only: [:destroy]

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
    @comment.destroy
    redirect_to @ferment, notice: 'Comentario eliminado con éxito.'
  end


private

  def set_ferment
    @ferment = Ferment.find(params[:ferment_id])
  end

  def set_comment
    @comment = @ferment.comments.find(params[:id])
  end

  def authorize_user!
    redirect_to @ferment, alert: 'No tienes permiso para eliminar este comentario.' unless @comment.user == current_user
  end

  def comment_params
    params.require(:comment).permit(:title, :content)
  end
end
