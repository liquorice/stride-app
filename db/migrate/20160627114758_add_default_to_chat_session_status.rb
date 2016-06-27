class AddDefaultToChatSessionStatus < ActiveRecord::Migration
  def change
    change_column :chat_sessions, :status, :integer, default: 0
  end
end
