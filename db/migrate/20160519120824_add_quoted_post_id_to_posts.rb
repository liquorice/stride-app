class AddQuotedPostIdToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :quoted_post_id, :integer
  end
end
