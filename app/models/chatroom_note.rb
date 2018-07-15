class ChatroomNote < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  has_many :chatroom_note_comments, dependent: :destroy
end
