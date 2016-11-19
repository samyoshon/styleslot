class AddCardExpMonthToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :card_exp_month, :integer
  end
end
