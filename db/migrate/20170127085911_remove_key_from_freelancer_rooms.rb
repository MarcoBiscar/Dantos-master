class RemoveKeyFromFreelancerRooms < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :freelancer_rates, name: :fk_rails_0cc87bd5ae
  end
end
