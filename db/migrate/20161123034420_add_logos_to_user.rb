class AddLogosToUser < ActiveRecord::Migration
  def change
  	add_column :users, :logo_file_name, :string
    add_column :users, :logo_content_type, :string
    add_column :users, :logo_file_size, :integer
    add_column :users, :logo_updated_at, :datetime
  end
end
