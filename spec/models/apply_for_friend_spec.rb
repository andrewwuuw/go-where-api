require 'rails_helper'

RSpec.describe ApplyForFriend, type: :model do
  describe "Association" do
    it {is_expected.to belong_to(:user).class_name(:User).with_foreign_key(:user_id)}
    it {is_expected.to belong_to(:apply).class_name(:User).with_foreign_key(:apply_id)}
  end
end
