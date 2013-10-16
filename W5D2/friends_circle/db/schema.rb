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

ActiveRecord::Schema.define(:version => 20131016000721) do

  create_table "circle_memberships", :force => true do |t|
    t.integer  "circle_id",  :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "circle_memberships", ["circle_id"], :name => "index_circle_memberships_on_circle_id"
  add_index "circle_memberships", ["user_id", "circle_id"], :name => "index_circle_memberships_on_user_id_and_circle_id", :unique => true
  add_index "circle_memberships", ["user_id"], :name => "index_circle_memberships_on_user_id"

  create_table "circles", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "circles", ["name"], :name => "index_circles_on_name"
  add_index "circles", ["user_id", "name"], :name => "index_circles_on_user_id_and_name", :unique => true
  add_index "circles", ["user_id"], :name => "index_circles_on_user_id"

  create_table "friends", :force => true do |t|
    t.integer  "friended_id", :null => false
    t.integer  "friender_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "friends", ["friended_id"], :name => "index_friends_on_friended_id"
  add_index "friends", ["friender_id", "friended_id"], :name => "index_friends_on_friender_id_and_friended_id", :unique => true
  add_index "friends", ["friender_id"], :name => "index_friends_on_friender_id"

  create_table "users", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "password_digest", :null => false
    t.string   "session_token",   :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "reset_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["session_token"], :name => "index_users_on_session_token", :unique => true

end
