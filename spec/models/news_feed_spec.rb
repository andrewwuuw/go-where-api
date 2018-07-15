require 'rails_helper'

RSpec.describe NewsFeed, type: :model do
  describe "Association" do
    it {is_expected.to have_and_belong_to_many(:user)}
    it {is_expected.to have_many(:news_feed_photos).dependent(:destroy)}
    it {is_expected.to have_many(:news_feed_comments).dependent(:destroy)}
  end
end
