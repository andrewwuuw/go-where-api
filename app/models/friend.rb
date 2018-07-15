class Friend < ApplicationRecord
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"
  belongs_to :user ,  class_name: "User", foreign_key: "user_id"
end
