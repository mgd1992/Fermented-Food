class AddInstructionsToFerments < ActiveRecord::Migration[7.1]
  def change
    add_column :ferments, :instructions, :text
  end
end
