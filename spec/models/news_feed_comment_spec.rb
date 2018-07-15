require 'rails_helper'

RSpec.describe NewsFeedComment, type: :model do
  describe "Association" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to belong_to(:news_feed)}
  end
end
