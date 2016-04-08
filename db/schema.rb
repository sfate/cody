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

ActiveRecord::Schema.define(version: 20160408205143) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_tokens", force: :cascade do |t|
    t.string   "token_id"
    t.string   "token_digest"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "api_tokens", ["token_id"], name: "index_api_tokens_on_token_id", unique: true, using: :btree

  create_table "pull_requests", force: :cascade do |t|
    t.string   "status"
    t.string   "number"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "pending_reviews"
    t.string   "completed_reviews"
    t.string   "repository"
  end

  create_table "review_rules", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.string   "file_match"
    t.string   "reviewer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "repository"
  end

  create_table "settings", force: :cascade do |t|
    t.string "key"
    t.string "value"
  end

  add_index "settings", ["key", "value"], name: "index_settings_on_key_and_value", unique: true, using: :btree

end
