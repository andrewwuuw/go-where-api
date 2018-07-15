require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe "Association" do
    it {is_expected.to belong_to(:user).class_name(:User).with_foreign_key(:user_id)}
    it {is_expected.to belong_to(:friend).class_name(:User).with_foreign_key(:friend_id)}
  end
end
