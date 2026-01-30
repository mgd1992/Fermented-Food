class ReviewReminderJob < ApplicationJob
  queue_as :default

  def perform
    Ferment.where("review_date <= ? AND review_reminder_sent = ?", Date.today, false).find_each do |f|
      FermentMailer.review_reminder(f).deliver_later
      f.update!(review_reminder_sent: true)
    end
  end
end
