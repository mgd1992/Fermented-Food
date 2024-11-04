class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.references :ferment, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end