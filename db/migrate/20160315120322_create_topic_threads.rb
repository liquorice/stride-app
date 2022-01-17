class CreateTopicThreads < ActiveRecord::Migration[4.2]
  def change
    create_table :topic_threads do |t|
      t.references :topic, index: true, foreign_key: true
      t.string :name
      t.boolean :pinned, default: false
      t.boolean :locked, default: false
      t.references :user, index: true, foreign_key: true
      t.boolean :public, default: true
      t.string :tags, array: true

      t.timestamps null: false
    end
  end
end
