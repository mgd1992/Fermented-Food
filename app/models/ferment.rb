class Ferment < ApplicationRecord
  belongs_to :user
  has_many :ferment_recipes
  validates :user, presence: true
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true
  has_many_attached :photos
end
