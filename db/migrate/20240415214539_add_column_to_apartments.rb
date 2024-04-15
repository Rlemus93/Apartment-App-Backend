class AddColumnToApartments < ActiveRecord::Migration[7.1]
  def change
    add_column :apartments, :about, :text
  end
end
