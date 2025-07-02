class AddStartDateToFerments < ActiveRecord::Migration[7.1]
  def change
    add_column :ferments, :start_date, :datetime
  end
end
