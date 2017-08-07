class Activity::Camp < Activity
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros

  def days_before_begining
    (begin_date - Date.today).to_i
  end

  def days_before_ending
    (end_date - Date.today).to_i
  end

  def begun?
    @past ||= begin_date.past?
  end

  def ended?
    @ended ||= end_date.past?
  end

  # association macros

  # validation macros

  # callbacks

  # other

  protected

  # callback methods
  def begin_date
    sorted_course_start_dates.first
  end

  def end_date
    sorted_course_start_dates.last
  end

  def sorted_course_start_dates
    @sorted_course_start_dates ||= courses.includes(:stages).map(&:start_on).sort
  end
end
