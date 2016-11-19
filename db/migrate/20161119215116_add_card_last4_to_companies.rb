class AddCardLast4ToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :card_last4, :string
  end
end
