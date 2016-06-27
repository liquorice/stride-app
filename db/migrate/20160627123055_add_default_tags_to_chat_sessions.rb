class AddDefaultTagsToChatSessions < ActiveRecord::Migration
  def change
    change_column :chat_sessions, :tags, :string, array: true, default: []
  end
end
