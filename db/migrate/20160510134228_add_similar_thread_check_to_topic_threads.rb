class AddSimilarThreadCheckToTopicThreads < ActiveRecord::Migration[4.2]
  def change
    add_column :topic_threads, :similar_thread_check, :boolean
  end
end
