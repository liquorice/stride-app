class AddOrdinalToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :ordinal, :integer, default: 0
  end
end
