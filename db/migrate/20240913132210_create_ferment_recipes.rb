class CreateFermentRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :ferment_recipes do |t|
      t.string :name
      t.text :ingredients
      t.text :instructions
      t.references :ferment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
