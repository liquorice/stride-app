class AddVisibilityToChatMessages < ActiveRecord::Migration[4.2]
  def change
    add_column :chat_messages, :visible, :boolean, default: true
  end
end
