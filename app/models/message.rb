class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  validates :content, presence: true
  validates :sender, :recipient, presence: true
  validates :subject, presence: true
end
