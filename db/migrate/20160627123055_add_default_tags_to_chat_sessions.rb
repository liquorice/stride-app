class AddDefaultTagsToChatSessions < ActiveRecord::Migration[4.2]
  def change
    change_column :chat_sessions, :tags, :string, array: true, default: []
  end
end
