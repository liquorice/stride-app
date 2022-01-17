class AddVisibleToTopics < ActiveRecord::Migration[4.2]
  def change
    add_column :topics, :visible, :boolean, default: true
  end
end
