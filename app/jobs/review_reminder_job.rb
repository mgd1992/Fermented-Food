class ReviewReminderJob < ApplicationJob
  queue_as :default

  def perform
    Ferment.where("review_date <= ? AND review_reminder_sent = ?", Date.today, false)
           .find_each do |ferment|
      FermentMailer.review_reminder(ferment).deliver_later
      ferment.update!(review_reminder_sent: true)
    end
  end
end
