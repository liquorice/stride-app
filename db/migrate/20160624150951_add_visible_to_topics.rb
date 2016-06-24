class AddVisibleToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :visible, :boolean, default: true
  end
end
