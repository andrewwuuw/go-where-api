require 'rails_helper'

RSpec.describe Follower, type: :model do
  describe "Association" do
    it {is_expected.to belong_to(:user).class_name(:User).with_foreign_key(:user_id)}
    it {is_expected.to belong_to(:follower).class_name(:User).with_foreign_key(:follower_id)}
  end
end
