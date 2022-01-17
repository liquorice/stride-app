class AddStatusToNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :status, :integer, default: 0
  end
end
