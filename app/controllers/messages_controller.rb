class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = current_user.received_messages.order(created_at: :desc)
  end
  def show
    @message = current_user.received_messages.find(params[:id])
    @message.update(read: true) unless @message.read?
  end

  def new
    @recipient = User.find(params[:recipient_id])
    @message = current_user.sent_messages.build(recipient: @recipient)
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

  private

  def message_params
    params.require(:message).permit(:recipient_id, :subject, :content)
  end
end
