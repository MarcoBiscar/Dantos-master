class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :manager, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
