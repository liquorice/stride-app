class AddAvatarDataToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar_colour, :integer, default: 1
    add_column :users, :avatar_face, :integer, default: 1
  end
end
