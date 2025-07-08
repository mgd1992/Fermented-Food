class AddRevisarFermentosToFerments < ActiveRecord::Migration[7.1]
  def change
    add_column :ferments, :revisar_fermentos, :integer
  end
end
