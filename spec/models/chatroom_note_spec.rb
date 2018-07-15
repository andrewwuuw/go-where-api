require 'rails_helper'

RSpec.describe ChatroomNote, type: :model do
  describe "Association" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to belong_to(:chatroom)}
    it {is_expected.to have_many(:chatroom_note_comments).dependent(:destroy)}
  end
end
