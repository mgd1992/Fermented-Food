class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ferment
  before_action :set_comment, only: [:destroy]
  before_action :authorize_user!, only: [:destroy]

  def create
    @comment = @ferment.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("comments", partial: "comments/comment", locals: { comment: @comment, ferment: @ferment }),
            turbo_stream.replace("new_comment", partial: "comments/form", locals: { ferment: @ferment, comment: Comment.new })
          ]
        end
        format.html { redirect_to user_ferment_path(@user, @ferment) }
      else
        format.html { render "ferments/show", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(helpers.dom_id(@comment)) }
      format.html { redirect_to user_ferment_path(@user, @ferment), status: :see_other }
    end
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
