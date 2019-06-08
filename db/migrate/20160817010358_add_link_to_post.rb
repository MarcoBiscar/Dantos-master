class AddLinkToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :link_title, :string
    add_column :posts, :link_url, :string
    add_column :posts, :link_image, :string
    add_column :posts, :link_description, :string
  end
end
