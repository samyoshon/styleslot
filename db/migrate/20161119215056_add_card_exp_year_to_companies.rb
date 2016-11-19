class AddCardExpYearToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :card_exp_year, :integer
  end
end
