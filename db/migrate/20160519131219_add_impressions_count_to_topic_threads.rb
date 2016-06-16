class AddImpressionsCountToTopicThreads < ActiveRecord::Migration
  def change
    add_column :topic_threads, :impressions_count, :integer
  end
end
