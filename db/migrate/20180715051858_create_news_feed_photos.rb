class CreateNewsFeedPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :news_feed_photos do |t|
      t.references :news_feed, foreign_key: true
      t.string :path

      t.timestamps
    end
  end
end
