class AddAccessLevelToUser < ActiveRecord::Migration[4.2]
  def change
    add_reference :users, :access_level, index: true, foreign_key: true
  end
end
