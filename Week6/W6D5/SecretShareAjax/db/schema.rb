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

ActiveRecord::Schema.define(:version => 20131025234143) do

  create_table "friendships", :force => true do |t|
    t.integer  "friender_id", :null => false
    t.integer  "friendee_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "friendships", ["friendee_id"], :name => "index_friendships_on_friendee_id"
  add_index "friendships", ["friender_id", "friendee_id"], :name => "index_friendships_on_friender_id_and_friendee_id", :unique => true
  add_index "friendships", ["friender_id"], :name => "index_friendships_on_friender_id"

  create_table "secret_taggings", :force => true do |t|
    t.integer  "tag_id",     :null => false
    t.integer  "secret_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "secret_taggings", ["secret_id"], :name => "index_secret_taggings_on_secret_id"
  add_index "secret_taggings", ["tag_id", "secret_id"], :name => "index_secret_taggings_on_tag_id_and_secret_id", :unique => true
  add_index "secret_taggings", ["tag_id"], :name => "index_secret_taggings_on_tag_id"

  create_table "secrets", :force => true do |t|
    t.string   "title",        :null => false
    t.integer  "author_id",    :null => false
    t.integer  "recipient_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "secrets", ["author_id"], :name => "index_secrets_on_author_id"
  add_index "secrets", ["recipient_id"], :name => "index_secrets_on_recipient_id"

  create_table "tags", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

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
