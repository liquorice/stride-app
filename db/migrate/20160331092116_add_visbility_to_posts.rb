class AddVisbilityToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :visible, :boolean, default: true
    add_column :posts, :hidden_at, :datetime
  end
end
