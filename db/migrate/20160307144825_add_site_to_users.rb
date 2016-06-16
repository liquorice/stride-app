class AddSiteToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :site, index: true, foreign_key: true
  end
end
