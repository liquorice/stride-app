class AddPrivateChatSessionsToChatMessages < ActiveRecord::Migration[4.2]
  def change
    add_reference :chat_messages, :private_chat_session, index: true, foreign_key: true
  end
end
