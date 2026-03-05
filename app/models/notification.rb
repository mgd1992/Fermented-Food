class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read: false) }
  scope :recent, -> { order(created_at: :desc).limit(10) }

  after_create_commit -> {
    broadcast_prepend_to(
      "notifications_#{user_id}",
      target: "notifications_list",
      partial: "notifications/notification",
      locals: { notification: self }
    )
    broadcast_replace_to(
      "notifications_#{user_id}",
      target: "notifications_count",
      partial: "notifications/count",
      locals: { count: user.notifications.unread.count }
    )
  }
end
