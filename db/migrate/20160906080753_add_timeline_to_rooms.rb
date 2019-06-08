class AddTimelineToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :timeline, :string
  end
end
