class JoinTableNewsFeedUser < ActiveRecord::Migration[5.2]
  def change
    create_join_table :news_feeds, :users do |t|
      t.boolean :store, default: false
      t.boolean :like, default: false
      t.index [:news_feed_id, :user_id], unique: true
    end
  end
end
