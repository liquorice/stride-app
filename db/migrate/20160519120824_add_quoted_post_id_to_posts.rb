class AddQuotedPostIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :quoted_post_id, :integer
  end
end
