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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140517072027) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applies", force: true do |t|
    t.integer  "course_id"
    t.integer  "stage_id"
    t.integer  "schedule_id"
    t.string   "first_name",  null: false
    t.string   "last_name",   null: false
    t.string   "phone"
    t.string   "email",       null: false
    t.integer  "age"
    t.string   "gender"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "applies", ["course_id"], name: "index_applies_on_course_id", using: :btree
  add_index "applies", ["schedule_id"], name: "index_applies_on_schedule_id", using: :btree
  add_index "applies", ["stage_id"], name: "index_applies_on_stage_id", using: :btree

  create_table "authors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.string   "image"
    t.string   "title",           null: false
    t.text     "summary"
    t.text     "description"
    t.text     "what_will_learn"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subtitle"
  end

  create_table "events", force: true do |t|
    t.integer  "schedule_id", null: false
    t.integer  "speaker_id"
    t.time     "start_at",    null: false
    t.string   "title",       null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["schedule_id"], name: "index_events_on_schedule_id", using: :btree
  add_index "events", ["speaker_id"], name: "index_events_on_speaker_id", using: :btree

  create_table "faqs", force: true do |t|
    t.text     "question",                   null: false
    t.text     "answer",                     null: false
    t.boolean  "is_online",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_id",    default: 0,     null: false
  end

  create_table "posts", force: true do |t|
    t.string   "title",      null: false
    t.text     "content",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "author_id"
  end

  add_index "posts", ["author_id"], name: "index_posts_on_author_id", using: :btree

  create_table "redactor_images", force: true do |t|
    t.string   "image",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.integer  "stage_id",    null: false
    t.date     "date",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["stage_id"], name: "index_schedules_on_stage_id", using: :btree

  create_table "speakers", force: true do |t|
    t.string   "avatar"
    t.string   "name",                                null: false
    t.text     "summary"
    t.boolean  "is_online",    default: false,        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",         default: "consultant", null: false
    t.string   "title"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.string   "google_url"
    t.string   "blog_url"
    t.integer  "sort_id",      default: 0,            null: false
  end

  create_table "stages", force: true do |t|
    t.integer  "course_id",                 null: false
    t.string   "title",                     null: false
    t.text     "description"
    t.integer  "sort_id",     default: 0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "duration",    default: 0.0, null: false
  end

  add_index "stages", ["course_id"], name: "index_stages_on_course_id", using: :btree

end
