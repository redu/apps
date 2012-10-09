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

ActiveRecord::Schema.define(:version => 20121009123052) do

  create_table "apps", :force => true do |t|
    t.string   "name"
    t.string   "author"
    t.string   "language"
    t.text     "objective"
    t.text     "synopsis"
    t.text     "description"
    t.text     "classification"
    t.string   "country"
    t.text     "publishers"
    t.text     "submitters"
    t.string   "url"
    t.string   "copyright"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "apps_users", :force => true do |t|
    t.integer "user_id"
    t.integer "app_id"
  end

  add_index "apps_users", ["user_id", "app_id"], :name => "index_apps_users_on_user_id_and_app_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "app_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comments", ["user_id", "app_id"], :name => "index_comments_on_user_id_and_app_id"

  create_table "users", :force => true do |t|
    t.integer  "uid"
    t.string   "token"
    t.string   "login"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "role_cd"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users", ["uid"], :name => "index_users_on_uid"

end
