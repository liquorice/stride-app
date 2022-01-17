class AddTagsToChatSessions < ActiveRecord::Migration[4.2]
  def change
    add_column :chat_sessions, :tags, :string, array: true
  end
end
