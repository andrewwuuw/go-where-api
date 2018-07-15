class ApplyForFriend < ApplicationRecord
  belongs_to :apply, class_name: "User", foreign_key: "apply_id"
  belongs_to :user,  class_name: "User", foreign_key: "user_id"
end
