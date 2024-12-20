class Ferment < ApplicationRecord
  belongs_to :user
  has_many :ferment_recipes
  has_many_attached :photos
  has_many :comments, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true, length: { minimum: 20 }

  def ingredients_as_text
    ingredients.join(", ") if ingredients.present?
  end
end
