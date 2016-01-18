class AddDetailsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :type, :string
    add_column :posts, :qualifications, :text
    add_column :posts, :benefits, :text
    add_column :posts, :how_to, :text
    add_column :posts, :how_to_link, :text
  end
end
