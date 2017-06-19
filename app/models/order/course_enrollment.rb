class Order::CourseEnrollment < ActiveRecord::Base
  self.table_name = "course_enrollments"

  belongs_to :order
  belongs_to :activity_course, class_name: "::ActivityCourse"
end
