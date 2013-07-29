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

ActiveRecord::Schema.define(:version => 20130729142551) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "adverts", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "sector_ids"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "client_jobs", :force => true do |t|
    t.integer  "client_id"
    t.integer  "job_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "client_mentors", :force => true do |t|
    t.integer  "client_id"
    t.integer  "mentor_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "client_projects", :force => true do |t|
    t.integer  "client_id"
    t.integer  "project_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "organisation"
    t.string   "unconfirmed_email"
  end

  add_index "clients", ["email"], :name => "index_clients_on_email", :unique => true
  add_index "clients", ["reset_password_token"], :name => "index_clients_on_reset_password_token", :unique => true

  create_table "employer_profiles", :force => true do |t|
    t.string   "name"
    t.string   "bio"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "member_job_applications", :force => true do |t|
    t.integer  "member_id"
    t.integer  "job_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "member_mentor_applications", :force => true do |t|
    t.integer  "member_id"
    t.integer  "mentor_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "member_project_applications", :force => true do |t|
    t.integer  "member_id"
    t.string   "project_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "members", :force => true do |t|
    t.string   "email",                                     :default => "",    :null => false
    t.string   "encrypted_password",                        :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                             :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.string   "fname"
    t.string   "lname"
    t.date     "dob"
    t.string   "gender"
    t.string   "telephone"
    t.string   "sector_ids"
    t.string   "location"
    t.string   "employment_status"
    t.string   "academic_institution"
    t.string   "course"
    t.string   "cv"
    t.boolean  "settings_receive_email_updates",            :default => false
    t.boolean  "settings_pass_info_to_employment_agencies", :default => false
    t.boolean  "settings_mentoring_highschool",             :default => false
    t.boolean  "settings_pass_info_to_marketing",           :default => false
  end

  add_index "members", ["email"], :name => "index_members_on_email", :unique => true
  add_index "members", ["reset_password_token"], :name => "index_members_on_reset_password_token", :unique => true

  create_table "mentors", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "role_title"
    t.string   "sector_ids"
    t.string   "organisation"
    t.date     "closing_date"
    t.string   "location"
    t.string   "description"
    t.string   "email"
    t.string   "telephone"
    t.string   "image"
    t.boolean  "draft"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "internal",     :default => true
    t.boolean  "external",     :default => true
  end

  create_table "organisation_email_domains", :force => true do |t|
    t.string   "organisation"
    t.string   "domain"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "project_leader"
    t.string   "sector_ids"
    t.string   "organisation"
    t.date     "closing_date"
    t.string   "location"
    t.string   "description"
    t.string   "email"
    t.string   "telephone"
    t.boolean  "draft"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "image"
    t.string   "salary"
    t.boolean  "internal",       :default => true
    t.boolean  "external",       :default => true
  end

  create_table "sectors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "fname"
    t.string   "lname"
    t.string   "bio"
    t.string   "position"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
