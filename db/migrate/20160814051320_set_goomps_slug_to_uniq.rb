class SetGoompsSlugToUniq < ActiveRecord::Migration[5.0]
  def change
    add_index :goomps, :slug, unique: true
  end
end
