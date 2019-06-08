class AddQualityToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :quality, :string
    add_column :rooms, :description, :text
  end
end
