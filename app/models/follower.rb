class Follower < ApplicationRecord
  belongs_to :follower, class_name: "User", foreign_key: "follower_id"
  belongs_to :user,     class_name: "User", foreign_key: "user_id"
end
