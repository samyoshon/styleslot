class RemoveExpYearToCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :exp_year, :integer
  end
end
