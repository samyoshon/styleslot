class ChangeStringToText < ActiveRecord::Migration
  def up
  	change_column :users, :description, :text
    change_column :users, :expertise, :text
    change_column :users, :experience, :text
    change_column :users, :residence, :text
    change_column :users, :education, :text
    change_column :users, :skills, :text
    change_column :users, :languages, :text
  end

  def down
  	add_column :users, :description, :string
    add_column :users, :expertise, :string
    add_column :users, :experience, :string
    add_column :users, :residence, :string
    add_column :users, :education, :string
    add_column :users, :skills, :string
    add_column :users, :languages, :string
  end
end
