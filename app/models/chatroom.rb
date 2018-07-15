class Chatroom < ApplicationRecord
  has_many :chatroom_photos, dependent: :destroy
  has_many :chatroom_notes, dependent: :destroy
  has_many :chatroom_messages, dependent: :destroy
  has_many :chatroom_groups, dependent: :destroy
end
