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

ActiveRecord::Schema.define(version: 20160516171931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "description",   null: false
    t.datetime "date",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "meeting_point"
    t.string   "address"
    t.string   "search_param",  null: false
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "image"
  end

  create_table "friendships", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_user_id"
  end

  add_index "friendships", ["friend_user_id", "user_id"], name: "index_friendships_on_friend_user_id_and_user_id", unique: true, using: :btree
  add_index "friendships", ["user_id", "friend_user_id"], name: "index_friendships_on_user_id_and_friend_user_id", unique: true, using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invitations", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "rsvp"
  end

  add_index "invitations", ["event_id"], name: "index_invitations_on_event_id", using: :btree
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "pin"
    t.boolean  "verified",     default: false
    t.string   "access_token"
    t.decimal  "longitude"
    t.decimal  "latitude"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "username"
  end

end
