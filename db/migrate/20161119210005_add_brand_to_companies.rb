class AddBrandToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :brand, :integer
  end
end
