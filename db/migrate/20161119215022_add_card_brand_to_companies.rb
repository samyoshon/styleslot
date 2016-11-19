class AddCardBrandToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :card_brand, :string
  end
end
