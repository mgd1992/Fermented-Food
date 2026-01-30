class Ferment < ApplicationRecord
  belongs_to :user
  has_many_attached :photos, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
  validates :instructions, presence: true
  validates :description, presence: true
  validates :ingredients, presence: true
  validates :revisar_fermentos, numericality: { greater_than: 0, message: "Debe ser mayor a 0" }
  validates :start_date, presence: true

  before_save :set_review_date
  before_save :reset_reminder, if: :start_date_changed?

  def formatted_start_date
    start_date.strftime("%d/%m/%Y") if start_date.present?
  end

  def days_passed
    return 0 if start_date.nil?
    (Date.today - start_date.to_date).to_i
  end

  def progress_percentage
    return 0 if revisar_fermentos.to_i <= 0 || start_date.nil?

    percentage = (days_passed.to_f / revisar_fermentos.to_f * 100).round
    [[percentage, 0].max, 100].min
  end

  def days_left
    return 0 if revisar_fermentos.nil?
    [(revisar_fermentos - days_passed), 0].max
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

  def reset_reminder
    self.review_reminder_sent = false
  end
end
