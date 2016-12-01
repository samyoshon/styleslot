class AddUnlimitedToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :unlimited, :datetime
  end
end
