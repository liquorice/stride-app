class AddPrivateChatSessionsToChatMessages < ActiveRecord::Migration
  def change
    add_reference :chat_messages, :private_chat_session, index: true, foreign_key: true
  end
end
