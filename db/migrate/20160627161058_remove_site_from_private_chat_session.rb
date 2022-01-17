class RemoveSiteFromPrivateChatSession < ActiveRecord::Migration[4.2]
  def change
    remove_reference :private_chat_sessions, :site, index: true, foreign_key: true
  end
end
