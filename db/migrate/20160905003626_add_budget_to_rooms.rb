class AddBudgetToRooms < ActiveRecord::Migration[5.0]
  def change
    add_monetize :rooms, :budget
  end
end
