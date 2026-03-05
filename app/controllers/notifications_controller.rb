class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.includes(:actor, :notifiable).recent
    current_user.notifications.unread.each { |n| n.update(read: true) }
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.update(read: true)

    case @notification.notifiable_type
    when "Comment"
      comment = @notification.notifiable
      redirect_to comment ? ferment_path(comment.ferment_id, anchor: dom_id(comment)) : notifications_path
    when "Message"
      redirect_to @notification.notifiable ? message_path(@notification.notifiable) : notifications_path
    else
      redirect_to notifications_path
    end
  end
end
