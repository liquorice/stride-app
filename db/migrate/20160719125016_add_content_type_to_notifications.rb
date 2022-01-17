class AddContentTypeToNotifications < ActiveRecord::Migration[4.2]
  def change
    add_column :notifications, :content_type, :string
  end
end
