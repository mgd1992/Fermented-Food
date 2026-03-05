# == Schema Information
#
# Table name: ferments
#
#  id                   :bigint           not null, primary key
#  description          :text
#  fermentation_time    :string
#  ingredients          :text
#  instructions         :text
#  name                 :string
#  review_date          :date
#  review_reminder_sent :boolean          default(FALSE), not null
#  revisar_fermentos    :integer
#  start_date           :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  user_id              :bigint           not null
#
# Indexes
#
#  index_ferments_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Ferment < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_details,
                  against: {
                    name: 'A',
                    description: 'B',
                    ingredients: 'B'
                  },
                  using: {
                    tsearch: {
                      prefix: true,
                      dictionary: "spanish"
                    },
                    trigram: {
                      threshold: 0.2
                    }
                  }

  belongs_to :user
  has_many_attached :photos, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, :instructions, :description, :ingredients, :start_date, presence: true
  validates :revisar_fermentos, numericality: { greater_than: 0 }, allow_nil: false

  before_save :set_review_date
  before_save :reset_reminder, if: :start_date_changed?

  def formatted_start_date
    start_date.strftime("%d/%m/%Y") if start_date.present?
  end

  def days_passed
    return 0 if start_date.nil?

    (Time.zone.today - start_date.to_date).to_i
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

    percentage = (days_passed / total_days * 100).round
    percentage.clamp(0, 100)
  end

  def restart_cycle!
    update(start_date: Time.zone.today, review_reminder_sent: false)
  end

  def needs_review?
    review_date.present? && review_date <= Time.zone.today && !review_reminder_sent
  end

  private

  def set_review_date
    return unless start_date_changed? || revisar_fermentos_changed?
    return unless start_date.present? && revisar_fermentos.present?

    self.review_date = start_date.to_date + revisar_fermentos.days
    self.review_reminder_sent = false
  end

  def reset_reminder
    self.review_reminder_sent = false
  end
end
