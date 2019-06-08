class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.belongs_to :goomp, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end

    add_index :memberships, [:goomp_id, :user_id], unique: true
  end
end
