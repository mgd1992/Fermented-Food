class AddShareTokenToFerments < ActiveRecord::Migration[7.1]
  def change
    add_column :ferments, :share_token, :string
    add_index :ferments, :share_token, unique: true
  end
end
