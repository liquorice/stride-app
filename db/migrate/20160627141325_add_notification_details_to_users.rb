class AddNotificationDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email_opted_in, :boolean, default: false
    add_column :users, :sms_opted_in, :boolean, default: false
    add_column :users, :twitter_opted_in, :boolean, default: false
    add_column :users, :sms_contact, :string
    add_column :users, :twitter_contact, :string
  end
end
