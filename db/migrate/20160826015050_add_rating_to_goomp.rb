class AddRatingToGoomp < ActiveRecord::Migration[5.0]
  def change
    add_column :goomps, :rating, :float
  end
end
