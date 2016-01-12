class ChangeZipToString < ActiveRecord::Migration
  def change
  	change_column :posts, :zip, :string
  end
end
