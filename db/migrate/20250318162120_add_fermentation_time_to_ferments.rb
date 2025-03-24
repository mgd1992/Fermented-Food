class AddFermentationTimeToFerments < ActiveRecord::Migration[7.1]
  def change
    add_column :ferments, :fermentation_time, :string
  end
end
