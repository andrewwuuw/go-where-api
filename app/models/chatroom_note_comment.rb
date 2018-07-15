class ChatroomNoteComment < ApplicationRecord
  belongs_to :chatroom_note
  belongs_to :user
end
