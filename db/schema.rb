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

ActiveRecord::Schema.define(:version => 20130409224140) do

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

  create_table "employer_profiles", :force => true do |t|
    t.string   "name"
    t.string   "bio"
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

  create_table "member_projects_application", :force => true do |t|
    t.integer  "member_id"
    t.integer  "project_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
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
