class ActivityCourse < ApplicationRecord
  self.table_name = "activities_courses"
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  # association macros
  belongs_to :activity, inverse_of: :activity_courses
  belongs_to :course
  has_many :course_enrollments, class_name: "Order::CourseEnrollment"
  delegate :title, to: :course

  # validation macros

  # callbacks

  # other
  class << self
    def to_hash_with_title
      attrs = self.column_names

      includes(:course).map do |item|
        new_hash = item.attributes.merge(title: item.course.title)
        [item.id, new_hash]
      end.to_h
    end
  end

  protected
  # callback methods
end
