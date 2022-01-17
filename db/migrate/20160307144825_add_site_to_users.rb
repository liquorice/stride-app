class AddSiteToUsers < ActiveRecord::Migration[4.2]
  def change
    add_reference :users, :site, index: true, foreign_key: true
  end
end
