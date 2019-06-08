class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.text :body
      t.integer :comments_count
      t.belongs_to :goomp, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :subtopic, foreign_key: true

      t.timestamps
    end
  end
end
