class CreateFollows < ActiveRecord::Migration[5.0]
  def change
    create_table :follows do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :followable, polymorphic: true

      t.timestamps
    end
  end
end
