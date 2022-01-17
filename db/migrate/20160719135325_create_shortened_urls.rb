class CreateShortenedUrls < ActiveRecord::Migration[4.2]
  def change
    create_table :shortened_urls do |t|
      t.string :long_url
      t.string :short_url

      t.timestamps null: false
    end
  end
end
