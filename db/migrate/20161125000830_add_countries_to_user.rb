class AddCountriesToUser < ActiveRecord::Migration
  def change
  	add_column :users, :countrya, :string
    add_column :users, :countryb, :string
    add_column :users, :countryc, :string
  end
end
