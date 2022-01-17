class AddSiteToTopics < ActiveRecord::Migration[4.2]
  def change
    add_reference :topics, :site, index: true, foreign_key: true
  end
end
