class AddNotesToChatSessions < ActiveRecord::Migration[4.2]
  def change
    add_column :chat_sessions, :notes, :text
  end
end
