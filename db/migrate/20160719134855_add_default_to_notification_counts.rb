class AddDefaultToNotificationCounts < ActiveRecord::Migration[4.2]
  def change
    change_column :notifications, :email_count, :integer, default: 0
    change_column :notifications, :sms_count, :integer, default: 0
    change_column :notifications, :twitter_count, :integer, default: 0
  end
end
