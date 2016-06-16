class AddAccessLevelToUser < ActiveRecord::Migration
  def change
    add_reference :users, :access_level, index: true, foreign_key: true
  end
end
