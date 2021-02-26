class AddHouseholdSizeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :household_size, :integer
  end
end
