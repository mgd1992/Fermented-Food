class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @received_messages = Message.where(recipient: current_user).order(created_at: :desc)
    @sent_messages = Message.where(sender: current_user).order(created_at: :desc)
    @active_tab = params[:tab] || 'received'
  end
  def show
    @message = Message.where("sender_id = :user_id OR recipient_id = :user_id", user_id: current_user.id).find_by(id: params[:id])

    if @message.nil?
      redirect_to messages_path, alert: "No tienes permiso para ver este mensaje o no existe."
      return
    end

    if @message.recipient == current_user && !@message.read?
      @message.update(read: true)
    end
  end

  def new
    @recipient = User.find(params[:recipient_id])
    @subject = params[:subject]
    @message = current_user.sent_messages.build(recipient: @recipient, subject: @subject)
  end

  def create
    @message = current_user.sent_messages.build(message_params)
    @recipient = @message.recipient

    if @message.save
      redirect_to messages_path, notice: "Mensaje enviado ✅"
    else
      render :new
    end
  end

  def destroy
    @message = Message.where("sender_id = :id OR recipient_id = :id", id: current_user.id).find(params[:id])
    @message.destroy

    respond_to do |format|
      # Forzamos la redirección en ambos formatos
      format.html { redirect_to messages_path, notice: "Mensaje eliminado", status: :see_other }
      format.turbo_stream { redirect_to messages_path, notice: "Mensaje eliminado", status: :see_other }
    end
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :subject, :content)
  end
end
