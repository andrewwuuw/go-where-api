require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Association" do
    it{is_expected.to have_one(:profile)}
    it{is_expected.to accept_nested_attributes_for(:profile)}
    it{is_expected.to have_and_belong_to_many(:news_feeds).dependent(:destroy)}
    it{is_expected.to have_many(:news_feed_comments).dependent(:destroy)}
    it{is_expected.to have_many(:chatroom_notes).dependent(:destroy)}
    it{is_expected.to have_many(:chatroom_note_comments).dependent(:destroy)}
    it{is_expected.to have_many(:chatroom_messages).dependent(:destroy)}
    it{is_expected.to have_many(:chatroom_groups).dependent(:destroy)}
    it{is_expected.to have_many(:users_friend).dependent(:destroy).class_name(:Friend).with_foreign_key(:user_id)}
    it{is_expected.to have_many(:friends_friend).dependent(:destroy).class_name(:Friend).with_foreign_key(:friend_id)}
    it{is_expected.to have_many(:users_follower).dependent(:destroy).class_name(:Follower).with_foreign_key(:user_id)}
    it{is_expected.to have_many(:followers_follower).dependent(:destroy).class_name(:Follower).with_foreign_key(:follower_id)}
    it{is_expected.to have_many(:users_apply_for_friend).dependent(:destroy).class_name(:ApplyForFriend).with_foreign_key(:user_id)}
    it{is_expected.to have_many(:applicants_apply_for_friend).dependent(:destroy).class_name(:ApplyForFriend).with_foreign_key(:apply_id)}
    it{is_expected.to have_many(:users_apply_for_follower).dependent(:destroy).class_name(:ApplyForFollow).with_foreign_key(:user_id)}
    it{is_expected.to have_many(:applicants_apply_for_follower).dependent(:destroy).class_name(:ApplyForFollow).with_foreign_key(:apply_id)}
  end
end
