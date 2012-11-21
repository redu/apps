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

ActiveRecord::Schema.define(:version => 20121121172614) do

  create_table "app_category_associations", :force => true do |t|
    t.integer  "app_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "app_category_associations", ["app_id", "category_id"], :name => "index_app_category_associations_on_app_id_and_category_id"

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
    t.integer  "views",                  :default => 0
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "token"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "app_id"
    t.integer  "in_response_to_id"
    t.text     "body"
    t.integer  "type_cd",           :default => 0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "comments", ["user_id", "app_id", "in_response_to_id", "type_cd"], :name => "index_comments_on_user_and_app_and_type_columns"

  create_table "courses", :force => true do |t|
    t.integer  "cid"
    t.string   "name"
    t.integer  "user_id"
    t.integer  "environment_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "zombie"
  end

  add_index "courses", ["cid", "name", "user_id"], :name => "index_courses_on_cid_and_name_and_user_id"

  create_table "environments", :force => true do |t|
    t.integer  "eid"
    t.string   "name"
    t.integer  "user_id"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.boolean  "zombie"
  end

  add_index "environments", ["eid", "name", "user_id"], :name => "index_environments_on_eid_and_name_and_user_id"

  create_table "lectures", :force => true do |t|
    t.integer  "lid"
    t.string   "name"
    t.integer  "subject_id"
    t.integer  "app_id"
    t.string   "lectureable_type"
    t.integer  "lectureable_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "lectures", ["lid", "name", "subject_id"], :name => "index_lectures_on_lid_and_name_and_subject_id"

  create_table "rs_evaluations", :force => true do |t|
    t.string   "reputation_name"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.float    "value",           :default => 0.0
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "rs_evaluations", ["reputation_name", "source_id", "source_type", "target_id", "target_type"], :name => "index_rs_evaluations_on_reputation_name_and_source_and_target", :unique => true
  add_index "rs_evaluations", ["reputation_name"], :name => "index_rs_evaluations_on_reputation_name"
  add_index "rs_evaluations", ["source_id", "source_type"], :name => "index_rs_evaluations_on_source_id_and_source_type"
  add_index "rs_evaluations", ["target_id", "target_type"], :name => "index_rs_evaluations_on_target_id_and_target_type"

  create_table "rs_reputation_messages", :force => true do |t|
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "receiver_id"
    t.float    "weight",      :default => 1.0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "rs_reputation_messages", ["receiver_id", "sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_receiver_id_and_sender", :unique => true
  add_index "rs_reputation_messages", ["receiver_id"], :name => "index_rs_reputation_messages_on_receiver_id"
  add_index "rs_reputation_messages", ["sender_id", "sender_type"], :name => "index_rs_reputation_messages_on_sender_id_and_sender_type"

  create_table "rs_reputations", :force => true do |t|
    t.string   "reputation_name"
    t.float    "value",           :default => 0.0
    t.string   "aggregated_by"
    t.integer  "target_id"
    t.string   "target_type"
    t.boolean  "active",          :default => true
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "rs_reputations", ["reputation_name", "target_id", "target_type"], :name => "index_rs_reputations_on_reputation_name_and_target", :unique => true
  add_index "rs_reputations", ["reputation_name"], :name => "index_rs_reputations_on_reputation_name"
  add_index "rs_reputations", ["target_id", "target_type"], :name => "index_rs_reputations_on_target_id_and_target_type"

  create_table "screen_shots", :force => true do |t|
    t.integer  "app_id"
    t.string   "screen_file_name"
    t.string   "screen_content_type"
    t.integer  "screen_file_size"
    t.datetime "screen_updated_at"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "screen_shots", ["app_id"], :name => "index_screen_shots_on_app_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "spaces", :force => true do |t|
    t.integer  "sid"
    t.string   "name"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "zombie"
  end

  add_index "spaces", ["sid", "name", "course_id"], :name => "index_spaces_on_sid_and_name_and_course_id"

  create_table "subjects", :force => true do |t|
    t.integer  "suid"
    t.string   "name"
    t.integer  "space_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "zombie"
  end

  add_index "subjects", ["suid", "name", "space_id"], :name => "index_subjects_on_suid_and_name_and_space_id"

  create_table "user_app_associations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "app_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_app_associations", ["user_id", "app_id"], :name => "index_user_app_associations_on_user_id_and_app_id"

  create_table "user_course_associations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "ucaid"
    t.integer  "role_cd"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "zombie"
  end

  add_index "user_course_associations", ["user_id", "course_id"], :name => "index_user_course_associations_on_user_id_and_course_id"

  create_table "user_environment_associations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "environment_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "user_environment_associations", ["user_id", "environment_id"], :name => "index_user_environment_associations_on_user_and_environment_ids"

  create_table "users", :force => true do |t|
    t.integer  "uid"
    t.string   "token"
    t.string   "login"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "role_cd",                :default => 1
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "email"
    t.string   "persistence_token"
    t.boolean  "zombie"
  end

  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["uid"], :name => "index_users_on_uid"

end
