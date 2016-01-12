class ChangeZipToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :zip, :integer
  end
end
