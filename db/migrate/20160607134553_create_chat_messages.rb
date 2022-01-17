class CreateChatMessages < ActiveRecord::Migration[4.2]
  def change
    create_table :chat_messages do |t|
      t.references :chat_session, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
