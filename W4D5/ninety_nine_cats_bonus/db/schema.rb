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

ActiveRecord::Schema.define(:version => 20131012000657) do

  create_table "cat_rentals", :force => true do |t|
    t.integer  "cat_id",                            :null => false
    t.date     "start_date",                        :null => false
    t.date     "end_date",                          :null => false
    t.string   "status",     :default => "PENDING"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "cat_rentals", ["cat_id"], :name => "index_cat_rentals_on_cat_id"

  create_table "cats", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "age",        :null => false
    t.date     "birth_date", :null => false
    t.string   "gender",     :null => false
    t.string   "color",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "owner_id"
  end

  add_index "cats", ["owner_id"], :name => "index_cats_on_owner_id"

  create_table "session_tokens", :force => true do |t|
    t.string   "session_token", :null => false
    t.string   "device",        :null => false
    t.string   "ip",            :null => false
    t.integer  "user_id",       :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "session_tokens", ["user_id"], :name => "index_session_tokens_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "username",        :null => false
    t.string   "password_digest", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
