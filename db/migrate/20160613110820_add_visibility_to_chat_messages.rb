class AddVisibilityToChatMessages < ActiveRecord::Migration
  def change
    add_column :chat_messages, :visible, :boolean, default: true
  end
end
