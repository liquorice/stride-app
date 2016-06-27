class AddDiscreetNameToChatSessions < ActiveRecord::Migration
  def change
    add_column :chat_sessions, :discreet_name, :string
  end
end
