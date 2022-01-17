class AddStatusToPrivateChatSessions < ActiveRecord::Migration[4.2]
  def change
    add_column :private_chat_sessions, :status, :integer, default: 0
  end
end
