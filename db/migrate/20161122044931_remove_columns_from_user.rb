class RemoveColumnsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :expertise, :string
    remove_column :users, :experience, :integer
    remove_column :users, :residence, :string
    remove_column :users, :education, :string
    remove_column :users, :skills, :string
    remove_column :users, :languages, :string
    remove_column :users, :facebook, :string
    remove_column :users, :linkedin, :string
    remove_column :users, :description, :string
    remove_column :users, :countrya, :string
    remove_column :users, :countryb, :string
    remove_column :users, :countryc, :string
  end
end
