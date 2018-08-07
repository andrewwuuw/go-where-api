# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_07_27_125747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apply_for_follows", force: :cascade do |t|
    t.bigint "apply_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["apply_id"], name: "index_apply_for_follows_on_apply_id"
    t.index ["user_id"], name: "index_apply_for_follows_on_user_id"
  end

  create_table "apply_for_friends", force: :cascade do |t|
    t.bigint "apply_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["apply_id"], name: "index_apply_for_friends_on_apply_id"
    t.index ["user_id"], name: "index_apply_for_friends_on_user_id"
  end

  create_table "chatroom_groups", force: :cascade do |t|
    t.bigint "chatroom_id"
    t.bigint "user_id"
    t.boolean "is_notify", default: true
    t.boolean "float_top", default: false
    t.boolean "is_admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_chatroom_groups_on_chatroom_id"
    t.index ["user_id"], name: "index_chatroom_groups_on_user_id"
  end

  create_table "chatroom_messages", force: :cascade do |t|
    t.bigint "chatroom_id"
    t.integer "message_type"
    t.text "content"
    t.integer "child"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_chatroom_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_chatroom_messages_on_user_id"
  end

  create_table "chatroom_note_comments", force: :cascade do |t|
    t.bigint "chatroom_note_id"
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_note_id"], name: "index_chatroom_note_comments_on_chatroom_note_id"
    t.index ["user_id"], name: "index_chatroom_note_comments_on_user_id"
  end

  create_table "chatroom_notes", force: :cascade do |t|
    t.bigint "chatroom_id"
    t.bigint "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_chatroom_notes_on_chatroom_id"
    t.index ["user_id"], name: "index_chatroom_notes_on_user_id"
  end

  create_table "chatroom_photos", force: :cascade do |t|
    t.bigint "chatroom_id"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_chatroom_photos_on_chatroom_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.boolean "is_group", default: false
    t.string "name"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "follower_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follower_id"], name: "index_followers_on_follower_id"
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.bigint "friend_id"
    t.bigint "user_id"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friends_on_friend_id"
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "news_feed_comments", force: :cascade do |t|
    t.bigint "news_feed_id"
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_feed_id"], name: "index_news_feed_comments_on_news_feed_id"
    t.index ["user_id"], name: "index_news_feed_comments_on_user_id"
  end

  create_table "news_feed_photos", force: :cascade do |t|
    t.bigint "news_feed_id"
    t.string "path"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_feed_id"], name: "index_news_feed_photos_on_news_feed_id"
  end

  create_table "news_feeds", force: :cascade do |t|
    t.bigint "user_id"
    t.decimal "lat", precision: 10, scale: 7
    t.decimal "lng", precision: 10, scale: 7
    t.string "title"
    t.text "description"
    t.boolean "is_private", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_news_feeds_on_user_id"
  end

  create_table "news_feeds_users", id: false, force: :cascade do |t|
    t.bigint "news_feed_id", null: false
    t.bigint "user_id", null: false
    t.boolean "store", default: false
    t.boolean "like", default: false
    t.index ["news_feed_id", "user_id"], name: "index_news_feeds_users_on_news_feed_id_and_user_id", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "avatar"
    t.string "phone"
    t.integer "gender", default: 0
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "scenic_spot_photos", force: :cascade do |t|
    t.bigint "scenic_spot_id"
    t.string "path"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scenic_spot_id"], name: "index_scenic_spot_photos_on_scenic_spot_id"
  end

  create_table "scenic_spots", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.text "description_detail"
    t.string "phone"
    t.string "address"
    t.string "open_time"
    t.decimal "lat", precision: 10, scale: 7
    t.decimal "lng", precision: 10, scale: 7
    t.string "city"
    t.text "travel_info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authentication_token"
    t.datetime "authentication_token_time"
    t.string "refresh_token"
    t.datetime "refresh_token_time"
    t.integer "device_type"
    t.string "device_token"
    t.boolean "is_public", default: true
    t.string "identifier"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["refresh_token"], name: "index_users_on_refresh_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "apply_for_follows", "users"
  add_foreign_key "apply_for_follows", "users", column: "apply_id"
  add_foreign_key "apply_for_friends", "users"
  add_foreign_key "apply_for_friends", "users", column: "apply_id"
  add_foreign_key "chatroom_groups", "chatrooms"
  add_foreign_key "chatroom_groups", "users"
  add_foreign_key "chatroom_messages", "chatrooms"
  add_foreign_key "chatroom_messages", "users"
  add_foreign_key "chatroom_note_comments", "chatroom_notes"
  add_foreign_key "chatroom_note_comments", "users"
  add_foreign_key "chatroom_notes", "chatrooms"
  add_foreign_key "chatroom_notes", "users"
  add_foreign_key "chatroom_photos", "chatrooms"
  add_foreign_key "followers", "users"
  add_foreign_key "followers", "users", column: "follower_id"
  add_foreign_key "friends", "users"
  add_foreign_key "friends", "users", column: "friend_id"
  add_foreign_key "news_feed_comments", "news_feeds"
  add_foreign_key "news_feed_comments", "users"
  add_foreign_key "news_feed_photos", "news_feeds"
  add_foreign_key "news_feeds", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "scenic_spot_photos", "scenic_spots"
end
