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

ActiveRecord::Schema.define(:version => 20131008232258) do

  create_table "statuses", :force => true do |t|
    t.integer  "twitter_status_id", :null => false
    t.string   "body",              :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "twitter_user_id"
  end

  add_index "statuses", ["twitter_status_id"], :name => "index_statuses_on_twitter_status_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "screen_name",     :null => false
    t.integer  "twitter_user_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["twitter_user_id"], :name => "index_users_on_twitter_user_id", :unique => true

end
