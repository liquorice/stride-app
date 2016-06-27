class RemoveSiteFromPrivateChatSession < ActiveRecord::Migration
  def change
    remove_reference :private_chat_sessions, :site, index: true, foreign_key: true
  end
end
