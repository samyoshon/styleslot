class RemoveBrandToCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :brand, :integer
  end
end
