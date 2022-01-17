class AddDiscreetNameToChatSessions < ActiveRecord::Migration[4.2]
  def change
    add_column :chat_sessions, :discreet_name, :string
  end
end
