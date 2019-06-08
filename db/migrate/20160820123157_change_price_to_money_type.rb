class ChangePriceToMoneyType < ActiveRecord::Migration[5.0]
  def change
    rename_column :goomps, :price, :price_tmp
    add_monetize :goomps, :price, amount: { null: true, default: nil }
    Goomp.find_each do |goomp|
      goomp.update price: goomp.price_tmp.to_f
    end
    remove_column :goomps, :price_tmp
  end
end
