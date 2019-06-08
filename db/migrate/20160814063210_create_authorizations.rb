class CreateAuthorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :authorizations do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.string :refresh_token
      t.datetime :expires_at
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
    add_index :authorizations, :provider
    add_index :authorizations, :uid
  end
end
