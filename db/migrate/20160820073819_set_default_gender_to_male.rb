class SetDefaultGenderToMale < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :gender, :string, default: "male"
  end
end
