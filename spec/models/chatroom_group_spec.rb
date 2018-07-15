require 'rails_helper'

RSpec.describe ChatroomGroup, type: :model do
  describe "Association" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to belong_to(:chatroom)}
  end
end
