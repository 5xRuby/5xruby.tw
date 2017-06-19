class CreateCourseEnrollmentTable < ActiveRecord::Migration[5.0]
  def change
    create_table :course_enrollments do |t|
      t.references :activity_course, references: :activities_courses, type: :uuid
      t.references :order
    end
  end
end
