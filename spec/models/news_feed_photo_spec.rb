require 'rails_helper'

RSpec.describe NewsFeedPhoto, type: :model do
  describe "Association" do
    it {is_expected.to belong_to(:news_feed)}
  end
end
