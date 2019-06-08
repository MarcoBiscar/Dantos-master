class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :goomp, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.integer :rating
      t.text :body

      t.timestamps
    end
  end
end
