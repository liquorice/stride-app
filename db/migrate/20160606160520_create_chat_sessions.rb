class CreateChatSessions < ActiveRecord::Migration
  def change
    create_table :chat_sessions do |t|
      t.string :name
      t.string :description
      t.datetime :scheduled_for
      t.integer :status

      t.timestamps null: false
    end
  end
end
