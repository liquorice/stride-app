class AddSiteToChatSessions < ActiveRecord::Migration
  def change
    add_reference :chat_sessions, :site, index: true, foreign_key: true
  end
end
