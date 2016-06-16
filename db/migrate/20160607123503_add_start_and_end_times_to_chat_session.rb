class AddStartAndEndTimesToChatSession < ActiveRecord::Migration
  def change
    add_column :chat_sessions, :started_at, :datetime
    add_column :chat_sessions, :ended_at, :datetime
  end
end
