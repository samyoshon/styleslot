class AddLast4ToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :last4, :string
  end
end
