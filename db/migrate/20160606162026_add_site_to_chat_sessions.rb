class AddSiteToChatSessions < ActiveRecord::Migration[4.2]
  def change
    add_reference :chat_sessions, :site, index: true, foreign_key: true
  end
end
