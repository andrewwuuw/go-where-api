require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  describe "Association" do
    it {is_expected.to have_many(:chatroom_photos).dependent(:destroy)}
    it {is_expected.to have_many(:chatroom_notes).dependent(:destroy)}
    it {is_expected.to have_many(:chatroom_messages).dependent(:destroy)}
    it {is_expected.to have_many(:chatroom_groups).dependent(:destroy)}
  end
end
