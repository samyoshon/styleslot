class AddExpMonthToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :exp_month, :integer
  end
end
