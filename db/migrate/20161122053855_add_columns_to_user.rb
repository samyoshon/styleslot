class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :dob, :integer
    add_column :users, :citizenship, :string
    add_column :users, :facebook, :string
    add_column :users, :linkedin, :string
  end
end
