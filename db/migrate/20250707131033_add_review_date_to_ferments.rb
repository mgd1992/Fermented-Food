class AddReviewDateToFerments < ActiveRecord::Migration[7.1]
  def change
    add_column :ferments, :review_date, :date
  end
end
