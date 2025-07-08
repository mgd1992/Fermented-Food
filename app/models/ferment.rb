class Ferment < ApplicationRecord
  before_create :set_review_date
  belongs_to :user
  has_many :ferment_recipes, dependent: :destroy
  has_many_attached :photos, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
  validates :instructions, presence: true
  validates :ingredients, presence: true


  def formatted_start_date
    start_date.strftime("%d/%m/%Y") if start_date.present?
  end

  def review_date
    start_date + revisarFermentos.days if start_date && revisarFermentos
  end

  def needs_review?
    review_date.present? && review_date <= Date.today
  end

  private

  def set_review_date
    if start_date.present? && revisar_fermentos.present?
      self.review_date = start_date + revisar_fermentos.days
    end
  end

end
