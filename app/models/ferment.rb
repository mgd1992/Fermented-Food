class Ferment < ApplicationRecord
  include MeiliSearch::Rails

  belongs_to :user
  has_many :ferment_recipes, dependent: :destroy
  has_many_attached :photos, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
  validates :instructions, presence: true

  meilisearch do
    attribute :name, :ingredients, :instructions, :fermentation_time

    searchable_attributes [:name, :ingredients, :instructions, :fermentation_time]
    filterable_attributes [:name, :ingredients, :instructions, :fermentation_time]
    sortable_attributes [:created_at]
  end
end
