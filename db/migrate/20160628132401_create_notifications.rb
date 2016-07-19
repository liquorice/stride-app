class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :email_count
      t.integer :sms_count
      t.integer :twitter_count
      t.text :content

      t.timestamps null: false
    end
  end
end
