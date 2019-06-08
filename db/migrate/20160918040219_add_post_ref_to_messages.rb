class AddPostRefToMessages < ActiveRecord::Migration[5.0]
  def change
    add_reference :messages, :post, foreign_key: true
  end
end
