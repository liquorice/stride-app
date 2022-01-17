class AddVisbilityToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :visible, :boolean, default: true
    add_column :posts, :hidden_at, :datetime
  end
end
