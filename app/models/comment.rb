class Comment < ApplicationRecord

  belongs_to :ferment
  belongs_to :user

  validates :content, presence: true
  validates :title, presence: true
end
