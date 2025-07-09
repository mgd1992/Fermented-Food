class ReviewReminderJob < ApplicationJob
  queue_as :default

  def perform
    Ferment.where(review_date: Date.today).find_each do |ferment|
      FermentMailer.review_reminder(ferment).deliver_now
    end
  end
end
