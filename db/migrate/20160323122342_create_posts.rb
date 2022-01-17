class CreatePosts < ActiveRecord::Migration[4.2]
  def change
    create_table :posts do |t|
      t.references :topic_thread, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
