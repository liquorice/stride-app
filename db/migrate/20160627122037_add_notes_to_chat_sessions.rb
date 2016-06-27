class AddNotesToChatSessions < ActiveRecord::Migration
  def change
    add_column :chat_sessions, :notes, :text
  end
end
