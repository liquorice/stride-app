class AddContentTypeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :content_type, :string
  end
end
