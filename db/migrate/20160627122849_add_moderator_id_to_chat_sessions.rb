class AddModeratorIdToChatSessions < ActiveRecord::Migration
  def change
    add_column :chat_sessions, :moderator_id, :integer
  end
end
