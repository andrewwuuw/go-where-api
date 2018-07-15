class CreateNewsFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :news_feeds do |t|
      t.references :user, foreign_key: true
      t.decimal :lat, precision: 10, scale: 7
      t.decimal :lng, precision: 10, scale: 7
      t.string :title
      t.text :description
      t.boolean :is_private, default: false

      t.timestamps
    end
  end
end
