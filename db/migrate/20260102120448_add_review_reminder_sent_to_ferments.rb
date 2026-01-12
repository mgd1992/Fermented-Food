class AddReviewReminderSentToFerments < ActiveRecord::Migration[7.1]
  def change
    add_column :ferments, :review_reminder_sent, :boolean, default: false, null: false
  end
end
