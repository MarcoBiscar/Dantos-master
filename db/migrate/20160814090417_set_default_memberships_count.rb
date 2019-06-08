class SetDefaultMembershipsCount < ActiveRecord::Migration[5.0]
  def up
    change_column :goomps, :memberships_count, :integer, default: 0
  end

  def down
    change_column :goomps, :memberships_count, :integer
  end
end
