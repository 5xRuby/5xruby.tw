class UpdateActivitiesCourses < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'uuid-ossp'
    rename_table :activities_courses, :activities_courses_deprecated
    create_table :activities_courses, id: :uuid do |t|
      t.references :activity, foreign_key: true
      t.references :course, foreign_key: true
      t.decimal :price, null: false
      t.decimal :early_bird_price
      t.integer :priority
    end

    reversible do |dir|
      old_model = Class.new(ActiveRecord::Base)
      old_model.table_name = 'activities_courses_deprecated'
      new_model = Class.new(ActiveRecord::Base)
      new_model.table_name = 'activities_courses'

      dir.up do
        old_model.find_in_batches do |group|
          new_model.create!(group.as_json.map do |h|
            h['price'] = 0
            h.slice('activity_id', 'course_id', 'price')
          end)
        end
      end
    end
  end
end
