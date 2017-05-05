class Activity::Talk < Activity
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  # association macros

  # validation macros

  # callbacks

  # other

  def course
    courses.first
  end

  protected
  # callback methods
end
