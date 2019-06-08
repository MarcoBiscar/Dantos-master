class CreateGoomps < ActiveRecord::Migration[5.0]
  def change
    create_table :goomps do |t|
      t.string :name
      t.string :cover
      t.string :slug
      t.string :price
      t.string :description
      t.integer :memberships_count
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
