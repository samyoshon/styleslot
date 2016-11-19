class RemoveExpMonthToCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :exp_month, :integer
  end
end
