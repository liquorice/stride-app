# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160510134228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_levels", force: :cascade do |t|
    t.integer  "site_id"
    t.string   "name"
    t.json     "permissions_data", default: {}
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "access_levels", ["site_id"], name: "index_access_levels_on_site_id", using: :btree

  create_table "password_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "password_requests", ["user_id"], name: "index_password_requests_on_user_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.integer  "topic_thread_id"
    t.text     "content"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "user_id"
    t.boolean  "visible",         default: true
    t.datetime "hidden_at"
  end

  add_index "posts", ["topic_thread_id"], name: "index_posts_on_topic_thread_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name"
    t.string   "hosts",      default: [],              array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "topic_threads", force: :cascade do |t|
    t.integer  "topic_id"
    t.string   "name"
    t.boolean  "pinned",               default: false
    t.boolean  "locked",               default: false
    t.integer  "user_id"
    t.boolean  "public",               default: true
    t.string   "tags",                                              array: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.boolean  "similar_thread_check"
  end

  add_index "topic_threads", ["topic_id"], name: "index_topic_threads_on_topic_id", using: :btree
  add_index "topic_threads", ["user_id"], name: "index_topic_threads_on_user_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "site_id"
  end

  add_index "topics", ["site_id"], name: "index_topics_on_site_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "superuser",       default: false
    t.integer  "access_level_id"
    t.integer  "site_id"
    t.integer  "avatar_colour",   default: 1
    t.integer  "avatar_face",     default: 1
    t.datetime "last_seen"
  end

  add_index "users", ["access_level_id"], name: "index_users_on_access_level_id", using: :btree
  add_index "users", ["site_id"], name: "index_users_on_site_id", using: :btree

  add_foreign_key "access_levels", "sites"
  add_foreign_key "password_requests", "users"
  add_foreign_key "posts", "topic_threads"
  add_foreign_key "posts", "users"
  add_foreign_key "topic_threads", "topics"
  add_foreign_key "topic_threads", "users"
  add_foreign_key "topics", "sites"
  add_foreign_key "users", "access_levels"
  add_foreign_key "users", "sites"
end
