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

ActiveRecord::Schema.define(version: 20170619022600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "activities", force: :cascade do |t|
    t.string   "type"
    t.string   "title"
    t.string   "permalink"
    t.text     "note"
    t.text     "payment_note"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "is_online"
    t.integer  "survey_id"
    t.integer  "template_id"
    t.json     "rules",        default: {}
    t.index ["survey_id"], name: "index_activities_on_survey_id", using: :btree
    t.index ["template_id"], name: "index_activities_on_template_id", using: :btree
  end

  create_table "activities_courses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.integer "activity_id"
    t.integer "course_id"
    t.decimal "price",            null: false
    t.decimal "early_bird_price"
    t.integer "priority"
    t.index ["activity_id"], name: "index_activities_courses_on_activity_id", using: :btree
    t.index ["course_id"], name: "index_activities_courses_on_course_id", using: :btree
  end

  create_table "activities_courses_deprecated", force: :cascade do |t|
    t.integer "activity_id"
    t.integer "course_id"
    t.index ["activity_id"], name: "index_activities_courses_deprecated_on_activity_id", using: :btree
    t.index ["course_id"], name: "index_activities_courses_deprecated_on_course_id", using: :btree
  end

  create_table "activities_courses_orders", force: :cascade do |t|
    t.uuid    "activity_course_id"
    t.integer "order_id"
    t.index ["activity_course_id"], name: "index_activities_courses_orders_on_activity_course_id", using: :btree
    t.index ["order_id"], name: "index_activities_courses_orders_on_order_id", using: :btree
  end

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "camp_templates", force: :cascade do |t|
    t.json     "payload"
    t.string   "status"
    t.string   "lang"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "courses_count",  default: 0,     null: false
    t.boolean  "is_highlighted", default: false, null: false
    t.integer  "sort_id",        default: 0,     null: false
    t.string   "permalink",                      null: false
    t.index ["name"], name: "index_categories_on_name", using: :btree
    t.index ["permalink"], name: "index_categories_on_permalink", unique: true, using: :btree
  end

  create_table "courses", force: :cascade do |t|
    t.string   "image"
    t.string   "title",                             null: false
    t.text     "summary"
    t.text     "description"
    t.text     "what_will_learn"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subtitle"
    t.integer  "category_id"
    t.boolean  "is_online",         default: false, null: false
    t.string   "permalink",                         null: false
    t.text     "note"
    t.string   "apply_link"
    t.string   "iframe_html"
    t.integer  "maximum_attendees", default: 30,    null: false
    t.integer  "total_attendees",   default: 0,     null: false
    t.integer  "minimum_attendees", default: 5,     null: false
    t.text     "suitable_for"
    t.text     "payment_note"
    t.text     "time_description"
    t.datetime "time_limit"
    t.index ["category_id"], name: "index_courses_on_category_id", using: :btree
    t.index ["permalink"], name: "index_courses_on_permalink", unique: true, using: :btree
    t.index ["title"], name: "index_courses_on_title", using: :btree
  end

  create_table "courses_speakers", id: false, force: :cascade do |t|
    t.integer "course_id",  null: false
    t.integer "speaker_id", null: false
    t.index ["course_id", "speaker_id"], name: "index_courses_speakers_on_course_id_and_speaker_id", unique: true, using: :btree
    t.index ["speaker_id", "course_id"], name: "index_courses_speakers_on_speaker_id_and_course_id", unique: true, using: :btree
  end

  create_table "faqs", force: :cascade do |t|
    t.text     "question",                   null: false
    t.text     "answer",                     null: false
    t.boolean  "is_online",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sort_id",    default: 0,     null: false
  end

  create_table "index_picture_imgs", force: :cascade do |t|
    t.string  "src"
    t.string  "lang"
    t.string  "size"
    t.integer "index_picture_id"
  end

  create_table "index_pictures", force: :cascade do |t|
    t.string  "alt"
    t.string  "href"
    t.integer "ordering"
  end

  create_table "interview_questions", force: :cascade do |t|
    t.text     "question",                   null: false
    t.text     "answer",                     null: false
    t.integer  "sort_id",    default: 0,     null: false
    t.boolean  "is_online",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "omniauths", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.json     "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "purchasable_type"
    t.integer  "purchasable_id"
    t.string   "state"
    t.decimal  "amount",           precision: 31, scale: 1
    t.json     "fields"
    t.integer  "user_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["purchasable_type", "purchasable_id"], name: "index_orders_on_purchasable_type_and_purchasable_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "state"
    t.string   "type"
    t.string   "identifier", default: "", null: false
    t.datetime "paid_at"
    t.datetime "expiry_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["order_id"], name: "index_payments_on_order_id", using: :btree
    t.index ["user_id"], name: "index_payments_on_user_id", using: :btree
  end

# Could not dump table "posts" because of following StandardError
#   Unknown type 'markup_type' for column 'markup_type'

  create_table "redactor_images", force: :cascade do |t|
    t.string   "image",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "showcases", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "link"
    t.string   "image"
    t.boolean  "is_online",   default: false, null: false
    t.integer  "sort_id",     default: 0,     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category"
  end

  create_table "speakers", force: :cascade do |t|
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
    t.index ["name"], name: "index_speakers_on_name", using: :btree
  end

  create_table "speakers_videos", id: false, force: :cascade do |t|
    t.integer "video_id",   null: false
    t.integer "speaker_id", null: false
    t.index ["speaker_id", "video_id"], name: "index_speakers_videos_on_speaker_id_and_video_id", using: :btree
    t.index ["video_id", "speaker_id"], name: "index_speakers_videos_on_video_id_and_speaker_id", using: :btree
  end

  create_table "stages", force: :cascade do |t|
    t.integer  "course_id",                                   null: false
    t.string   "title",                                       null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date",        default: '2014-09-03',          null: false
    t.time     "start_at",    default: '2000-01-01 00:00:00', null: false
    t.time     "end_at",      default: '2000-01-01 00:00:00', null: false
    t.float    "hours",       default: 1.0,                   null: false
    t.index ["course_id"], name: "index_stages_on_course_id", using: :btree
  end

  create_table "surveys", force: :cascade do |t|
    t.string   "title"
    t.json     "questions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "taggable_type"
    t.integer  "taggable_id"
    t.string   "tagger_type"
    t.integer  "tagger_id"
    t.string   "context",       limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context", using: :btree
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy", using: :btree
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id", using: :btree
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type", using: :btree
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
  end

  create_table "translations", force: :cascade do |t|
    t.string   "translatable_type"
    t.integer  "translatable_id"
    t.string   "column"
    t.string   "locale"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["translatable_type", "translatable_id"], name: "index_translations_on_translatable_type_and_translatable_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "phone"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.string   "iframe"
    t.string   "summary"
    t.text     "description"
    t.boolean  "is_online"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  add_foreign_key "activities", "camp_templates", column: "template_id"
  add_foreign_key "activities", "surveys"
  add_foreign_key "activities_courses", "activities"
  add_foreign_key "activities_courses", "courses"
  add_foreign_key "activities_courses_deprecated", "activities"
  add_foreign_key "activities_courses_deprecated", "courses"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "orders"
  add_foreign_key "payments", "users"
end
