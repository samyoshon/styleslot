class AddJobTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :job_type, :string
  end
end
