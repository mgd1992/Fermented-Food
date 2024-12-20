class AddIngredientsToFerments < ActiveRecord::Migration[7.1]
  def change
    add_column :ferments, :ingredients, :text
  end
end
