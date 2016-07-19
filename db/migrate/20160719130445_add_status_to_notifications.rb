class AddStatusToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :status, :integer, default: 0
  end
end
