class AddDescriptionsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :description, :string
    add_column :users, :expertise, :string
    add_column :users, :experience, :string
    add_column :users, :residence, :string
    add_column :users, :education, :string
    add_column :users, :skills, :string
    add_column :users, :languages, :string
  end
end
