class AddTagsToChatSessions < ActiveRecord::Migration
  def change
    add_column :chat_sessions, :tags, :string, array: true
  end
end
