class AddPostsCountToGoomps < ActiveRecord::Migration[5.0]
  def change
    add_column :goomps, :posts_count, :integer, default: 0
  end
end
