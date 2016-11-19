class RemoveLast4ToCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :last4, :string
  end
end
