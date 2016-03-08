class AddSiteToTopics < ActiveRecord::Migration
  def change
    add_reference :topics, :site, index: true, foreign_key: true
  end
end
