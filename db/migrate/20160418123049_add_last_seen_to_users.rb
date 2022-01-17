class AddLastSeenToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :last_seen, :datetime
  end
end
