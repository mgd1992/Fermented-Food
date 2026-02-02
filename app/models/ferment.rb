class Ferment < ApplicationRecord
  belongs_to :user
  has_many_attached :photos, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :user, :name, :instructions, :description, :ingredients, :start_date, presence: true
  validates :revisar_fermentos, numericality: { greater_than: 0 }

  before_save :set_review_date
  before_save :reset_reminder, if: :start_date_changed?

  def formatted_start_date
    start_date.strftime("%d/%m/%Y") if start_date.present?
  end

  def days_passed
    return 0 if start_date.nil?
    (Date.today - start_date.to_date).to_i
  end

  def days_left
    return 0 if fermentation_time.blank? || start_date.nil?
    total = fermentation_time.to_i
    restante = total - days_passed
    [restante, 0].max
  end

  def progress_percentage
    return 0 if start_date.nil? || fermentation_time.blank?
    total_days = fermentation_time.to_i
    return 100 if total_days <= 0
    percentage = (days_passed.to_f / total_days.to_f * 100).round
    [[percentage, 0].max, 100].min
  end

  def restart_cycle!
    update(start_date: Date.today, review_reminder_sent: false)
  end

  def needs_review?
    review_date.present? && review_date <= Date.today && !review_reminder_sent
  end

  private

  def set_review_date
    if start_date_changed? || revisar_fermentos_changed?
      if start_date.present? && revisar_fermentos.present?
        self.review_date = start_date.to_date + revisar_fermentos.days
        self.review_reminder_sent = false
      end
    end
  end

  def reset_reminder
    self.review_reminder_sent = false
  end
end
