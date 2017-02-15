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

ActiveRecord::Schema.define(version: 20170215103824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "interview_questions", force: :cascade do |t|
    t.text     "question",                   null: false
    t.text     "answer",                     null: false
    t.integer  "sort_id",    default: 0,     null: false
    t.boolean  "is_online",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.index ["translatable_id", "translatable_type"], name: "index_translations_on_translatable_id_and_translatable_type", using: :btree
    t.index ["translatable_type", "translatable_id"], name: "index_translations_on_translatable_type_and_translatable_id", using: :btree
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

end
