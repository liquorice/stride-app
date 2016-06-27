class AddStatusToPrivateChatSessions < ActiveRecord::Migration
  def change
    add_column :private_chat_sessions, :status, :integer, default: 0
  end
end
