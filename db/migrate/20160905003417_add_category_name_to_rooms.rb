class AddCategoryNameToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :category_name, :string
  end
end
