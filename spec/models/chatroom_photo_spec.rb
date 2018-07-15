require 'rails_helper'

RSpec.describe ChatroomPhoto, type: :model do
  describe "Association" do
    it {is_expected.to belong_to(:chatroom)}
  end
end
