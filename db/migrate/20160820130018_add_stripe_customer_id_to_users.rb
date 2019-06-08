class AddStripeCustomerIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stipe_customer_id, :string
  end
end
