class AddModeratorIdToChatSessions < ActiveRecord::Migration[4.2]
  def change
    add_column :chat_sessions, :moderator_id, :integer
  end
end
