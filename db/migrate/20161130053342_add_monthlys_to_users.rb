class AddMonthlysToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :monthly, :datetime
  	add_column :companies, :monthly, :datetime
  end
end
