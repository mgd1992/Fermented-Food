class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.includes(:actor, :notifiable).recent
    current_user.notifications.unread.each { |n| n.update(read: true) }
  end

  def mark_as_read
    @notification = current_user.notifications.find(params[:id])
    @notification.update(read: true)
    redirect_to redirect_url_for(@notification)
  end

  def destroy
    @notification = current_user.notifications.find(params[:id])
    @notification.destroy
    respond_to do |f|
      f.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@notification)) }
      f.html { redirect_to notifications_path }
    end
  end

  private

  def redirect_url_for(notification)
    case notification.notifiable_type
    when "Comment"
      comment = notification.notifiable
      return notifications_path unless comment

      ferment = comment.ferment
      user_ferment_path(ferment.user_id, ferment, anchor: ActionView::RecordIdentifier.dom_id(comment))
    when "Message"
      notification.notifiable ? message_path(notification.notifiable) : notifications_path
    else
      notifications_path
    end
  end
end
