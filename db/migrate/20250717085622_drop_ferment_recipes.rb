class DropFermentRecipes < ActiveRecord::Migration[7.1]
  def change
    drop_table :ferment_recipes
  end
end
