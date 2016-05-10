class AddSimilarThreadCheckToTopicThreads < ActiveRecord::Migration
  def change
    add_column :topic_threads, :similar_thread_check, :boolean
  end
end
