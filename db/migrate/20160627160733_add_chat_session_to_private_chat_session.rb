class AddChatSessionToPrivateChatSession < ActiveRecord::Migration[4.2]
  def change
    add_reference :private_chat_sessions, :chat_session, index: true, foreign_key: true
  end
end
