class ReviewReminderJob < ApplicationJob
  queue_as :default

  def perform
    Ferment.where(review_date: Date.today).find_each do |ferment|
      FermentMailer.review_reminder(ferment).deliver_now
      #Rails.logger.info "📬 Sent review reminder for ferment #{ferment.id} to user #{ferment.user.email}"
    end
  end
end
