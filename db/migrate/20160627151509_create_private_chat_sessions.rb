class CreatePrivateChatSessions < ActiveRecord::Migration[4.2]
  def change
    create_table :private_chat_sessions do |t|
      t.references :site, index: true, foreign_key: true
      t.integer :moderator_id
      t.references :user, index: true, foreign_key: true
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps null: false
    end
  end
end
