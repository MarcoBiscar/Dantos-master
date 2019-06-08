class AddLogoToGoomp < ActiveRecord::Migration[5.0]
  def change
    add_column :goomps, :logo, :string
  end
end
