class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :expertise, :string
    add_column :users, :experience, :integer
    add_column :users, :residence, :string
    add_column :users, :education, :string
    add_column :users, :skills, :string
    add_column :users, :languages, :string
    add_column :users, :facebook, :string
    add_column :users, :linkedin, :string
    add_column :users, :description, :string
    add_column :users, :countrya, :string
    add_column :users, :countryb, :string
    add_column :users, :countryc, :string
  end
end
