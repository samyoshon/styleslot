class AddExpYearToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :exp_year, :integer
  end
end
