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

ActiveRecord::Schema.define(version: 20140914125456) do

  create_table "countries", force: true do |t|
    t.string   "name"
    t.string   "iso"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d11_leagues", force: true do |t|
    t.integer  "season_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "d11_teams", force: true do |t|
    t.integer  "owner_id"
    t.integer  "co_owner_id"
    t.string   "name"
    t.string   "code"
    t.string   "club_crest_file_name"
    t.string   "club_crest_content_type"
    t.integer  "club_crest_file_size"
    t.datetime "club_crest_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "player_season_infos", force: true do |t|
    t.integer  "player_id"
    t.integer  "season_id"
    t.integer  "team_id"
    t.integer  "d11_team_id"
    t.integer  "position_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.integer  "country_id"
    t.integer  "whoscored_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.date     "date_of_birth"
    t.integer  "height"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "player_photo_file_name"
    t.string   "player_photo_content_type"
    t.integer  "player_photo_file_size"
    t.datetime "player_photo_updated_at"
    t.string   "parameterized_name"
  end

  create_table "positions", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.boolean  "defender"
    t.integer  "sort_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "premier_leagues", force: true do |t|
    t.integer  "season_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seasons", force: true do |t|
    t.string   "name"
    t.integer  "status"
    t.date     "date"
    t.boolean  "legacy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stadia", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.integer  "capacity"
    t.integer  "opened"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "nickname"
    t.integer  "established"
    t.string   "motto"
    t.integer  "stadium_id"
    t.integer  "whoscored_id"
    t.string   "club_crest_file_name"
    t.string   "club_crest_content_type"
    t.integer  "club_crest_file_size"
    t.datetime "club_crest_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "colour"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "administrator",          default: false
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
