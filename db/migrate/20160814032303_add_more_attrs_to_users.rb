class AddMoreAttrsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_column :users, :bio, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :picture, :string
    add_column :users, :headline, :string
    add_column :users, :work_experience, :string
    add_column :users, :gender, :string
  end
end
