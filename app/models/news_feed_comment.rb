class NewsFeedComment < ApplicationRecord
  belongs_to :news_feed
  belongs_to :user
end
