class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :profile
  accepts_nested_attributes_for :profile
  has_and_belongs_to_many :news_feeds, dependent: :destroy
  has_many :news_feed_comments, dependent: :destroy
  has_many :chatroom_notes, dependent: :destroy
  has_many :chatroom_note_comments, dependent: :destroy
  has_many :chatroom_messages, dependent: :destroy
  has_many :chatroom_groups, dependent: :destroy
  has_many :users_friend,   :class_name => 'Friend', :foreign_key => 'user_id', dependent: :destroy
  has_many :friends_friend, :class_name => 'Friend', :foreign_key => 'friend_id', dependent: :destroy
  has_many :users_follower,     :class_name => 'Follower', :foreign_key => 'user_id', dependent: :destroy
  has_many :followers_follower, :class_name => 'Follower', :foreign_key => 'follower_id', dependent: :destroy
  # users_apply_for_friend: 我申請好友的對象
  # applicants_apply_for_friend: 申請我好友的人
  has_many :users_apply_for_friend,      :class_name => 'ApplyForFriend', :foreign_key => 'user_id', dependent: :destroy
  has_many :applicants_apply_for_friend, :class_name => 'ApplyForFriend', :foreign_key => 'apply_id', dependent: :destroy
  # users_apply_for_follower: 我申請追蹤的對象
  # applicants_apply_for_follower: 申請追蹤我的人
  has_many :users_apply_for_follower,      :class_name => 'ApplyForFollow', :foreign_key => 'user_id', dependent: :destroy
  has_many :applicants_apply_for_follower, :class_name => 'ApplyForFollow', :foreign_key => 'apply_id', dependent: :destroy

end
