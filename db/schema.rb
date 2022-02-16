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

ActiveRecord::Schema.define(version: 2022_01_17_073104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_levels", id: :serial, force: :cascade do |t|
    t.integer "site_id"
    t.string "name"
    t.json "permissions_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ordinal"
    t.index ["site_id"], name: "index_access_levels_on_site_id"
  end

  create_table "chat_messages", id: :serial, force: :cascade do |t|
    t.integer "chat_session_id"
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "visible", default: true
    t.integer "private_chat_session_id"
    t.index ["chat_session_id"], name: "index_chat_messages_on_chat_session_id"
    t.index ["private_chat_session_id"], name: "index_chat_messages_on_private_chat_session_id"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "chat_sessions", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "scheduled_for"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "site_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string "tags", default: [], array: true
    t.string "discreet_name"
    t.text "notes"
    t.integer "moderator_id"
    t.index ["site_id"], name: "index_chat_sessions_on_site_id"
  end

  create_table "impressions", id: :serial, force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "params"
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "email_count", default: 0
    t.integer "sms_count", default: 0
    t.integer "twitter_count", default: 0
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content_type"
    t.integer "status", default: 0
    t.string "subject_title", default: ""
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "password_requests", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_password_requests_on_user_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.integer "topic_thread_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.boolean "visible", default: true
    t.datetime "hidden_at"
    t.integer "quoted_post_id"
    t.index ["topic_thread_id"], name: "index_posts_on_topic_thread_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "private_chat_sessions", id: :serial, force: :cascade do |t|
    t.integer "moderator_id"
    t.integer "user_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.integer "chat_session_id"
    t.index ["chat_session_id"], name: "index_private_chat_sessions_on_chat_session_id"
    t.index ["user_id"], name: "index_private_chat_sessions_on_user_id"
  end

  create_table "shortened_urls", id: :serial, force: :cascade do |t|
    t.string "long_url"
    t.string "short_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sites", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "hosts", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "topic_threads", id: :serial, force: :cascade do |t|
    t.integer "topic_id"
    t.string "name"
    t.boolean "pinned", default: false
    t.boolean "locked", default: false
    t.integer "user_id"
    t.boolean "public", default: true
    t.string "tags", array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "similar_thread_check"
    t.integer "impressions_count"
    t.index ["topic_id"], name: "index_topic_threads_on_topic_id"
    t.index ["user_id"], name: "index_topic_threads_on_user_id"
  end

  create_table "topics", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "site_id"
    t.integer "ordinal", default: 0
    t.boolean "visible", default: true
    t.index ["site_id"], name: "index_topics_on_site_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "superuser", default: false
    t.integer "access_level_id"
    t.integer "site_id"
    t.integer "avatar_colour", default: 1
    t.integer "avatar_face", default: 1
    t.datetime "last_seen"
    t.boolean "suspended", default: false
    t.boolean "email_opted_in", default: false
    t.boolean "sms_opted_in", default: false
    t.boolean "twitter_opted_in", default: false
    t.string "sms_contact"
    t.string "twitter_contact"
    t.index ["access_level_id"], name: "index_users_on_access_level_id"
    t.index ["site_id"], name: "index_users_on_site_id"
  end

  add_foreign_key "access_levels", "sites"
  add_foreign_key "chat_messages", "chat_sessions"
  add_foreign_key "chat_messages", "private_chat_sessions"
  add_foreign_key "chat_messages", "users"
  add_foreign_key "chat_sessions", "sites"
  add_foreign_key "notifications", "users"
  add_foreign_key "password_requests", "users"
  add_foreign_key "posts", "topic_threads"
  add_foreign_key "posts", "users"
  add_foreign_key "private_chat_sessions", "chat_sessions"
  add_foreign_key "private_chat_sessions", "users"
  add_foreign_key "topic_threads", "topics"
  add_foreign_key "topic_threads", "users"
  add_foreign_key "topics", "sites"
  add_foreign_key "users", "access_levels"
  add_foreign_key "users", "sites"
end
