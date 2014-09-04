class DropAppliesSchedulesEvents < ActiveRecord::Migration
  def change
    drop_table :applies
    drop_table :schedules
    drop_table :events
  end

  def down
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

    create_table "schedules", force: true do |t|
      t.integer  "stage_id",    null: false
      t.date     "date",        null: false
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "schedules", ["stage_id"], name: "index_schedules_on_stage_id", using: :btree
  end
end
