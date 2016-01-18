class AddDetailsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :name, :string
    add_column :companies, :description, :text
    add_column :companies, :website, :string
    add_column :companies, :facebook, :string
    add_column :companies, :instagram, :string
    add_column :companies, :twitter, :string
  end
end
