class ActivityCourse < ApplicationRecord
  self.table_name = "activities_courses"
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  # association macros
  belongs_to :activity, inverse_of: :activity_courses
  belongs_to :course

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
