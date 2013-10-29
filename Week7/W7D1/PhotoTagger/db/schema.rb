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

ActiveRecord::Schema.define(:version => 20131028183811) do

  create_table "photo_taggings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "photo_id"
    t.integer  "x_pos"
    t.integer  "y_pos"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "photo_taggings", ["photo_id"], :name => "index_photo_taggings_on_photo_id"
  add_index "photo_taggings", ["user_id"], :name => "index_photo_taggings_on_user_id"
  add_index "photo_taggings", ["x_pos", "y_pos"], :name => "index_photo_taggings_on_x_pos_and_y_pos"

  create_table "photos", :force => true do |t|
    t.integer  "owner_id"
    t.string   "url"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "photos", ["owner_id"], :name => "index_photos_on_owner_id"
  add_index "photos", ["title"], :name => "index_photos_on_title"

  create_table "users", :force => true do |t|
    t.string   "username",        :null => false
    t.string   "password_digest", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "session_token",   :null => false
  end

  add_index "users", ["session_token"], :name => "index_users_on_session_token", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
