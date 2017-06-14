class CreateActivitiesCoursesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :activities_courses do |t|
      t.references :activity, foreign_key: true
      t.references :course, foreign_key: true
    end
  end
end
