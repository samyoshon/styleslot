class AddSalariesToPost < ActiveRecord::Migration
  def change
 	add_column :posts, :salary, :string
    add_column :posts, :airfare, :string
    add_column :posts, :housing, :string
    add_column :posts, :university, :boolean
    add_column :posts, :tefl, :boolean
    add_column :posts, :vacation, :string
    add_column :posts, :insurance, :string
  end
end
