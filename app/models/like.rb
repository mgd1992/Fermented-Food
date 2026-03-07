class Like < ApplicationRecord
  belongs_to :user
  belongs_to :ferment

  validates :user_id, uniqueness: { scope: :ferment_id, message: "Ya le diste like a este fermento" }

  after_create_commit :notify_ferment_owner

  private

  def notify_ferment_owner
    return if ferment.user == user

    Notification.create!(
      user: ferment.user,
      actor: user,
      notifiable: self,
      message: "#{user.first_name} le dio like a tu fermento: #{ferment.name}"
    )
  end
end
