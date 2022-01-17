class AddOrdinalToTopics < ActiveRecord::Migration[4.2]
  def change
    add_column :topics, :ordinal, :integer, default: 0
  end
end
