class AddPostViewCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_view_count, :integer
  end
end
