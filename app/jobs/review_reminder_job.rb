class ReviewReminderJob < ApplicationJob
  queue_as :default

  def perform
    Ferment.where("start_date + revisar_fermentos * interval '1 day' <= ? AND review_reminder_sent = false", Time.current)
           .find_each do |ferment|
      FermentMailer.review_reminder(ferment).deliver_later
      ferment.update!(review_reminder_sent: true)
    end
  end
end
