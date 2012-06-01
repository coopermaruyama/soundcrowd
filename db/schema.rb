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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120601033236) do

  create_table "comments", :force => true do |t|
    t.string   "comment"
    t.datetime "timestamp"
    t.integer  "reply_of"
    t.integer  "track_timestamp"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "follows", :force => true do |t|
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "follower_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.integer  "creator_id"
    t.integer  "versions"
    t.integer  "followers"
    t.string   "tags"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "bpm"
  end

  create_table "tag_relations", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "tagged_track"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tracks", :force => true do |t|
    t.integer  "creator"
    t.integer  "votes"
    t.integer  "forks"
    t.boolean  "original"
    t.integer  "forked_from"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "vsts"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.integer  "program"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "email"
  end

  create_table "vsts", :force => true do |t|
    t.string   "name"
    t.string   "source"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
