class NewsFeed < ApplicationRecord
  
  has_and_belongs_to_many :user
  has_many :news_feed_photos,   dependent: :destroy
  has_many :news_feed_comments, dependent: :destroy
end
