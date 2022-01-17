class AddDefaultToChatSessionStatus < ActiveRecord::Migration[4.2]
  def change
    change_column :chat_sessions, :status, :integer, default: 0
  end
end
