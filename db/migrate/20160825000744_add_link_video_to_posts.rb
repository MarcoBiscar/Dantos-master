class AddLinkVideoToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :link_video, :string
  end
end
