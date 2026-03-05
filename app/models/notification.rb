# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  message         :string           not null
#  notifiable_type :string           not null
#  read            :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  actor_id        :bigint           not null
#  notifiable_id   :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_notifications_on_actor_id          (actor_id)
#  index_notifications_on_notifiable        (notifiable_type,notifiable_id)
#  index_notifications_on_user_id           (user_id)
#  index_notifications_on_user_id_and_read  (user_id,read)
#
# Foreign Keys
#
#  fk_rails_...  (actor_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :unread, -> { where(read: false) }
  scope :recent, -> { order(created_at: :desc).limit(10) }

  after_create_commit lambda {
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
