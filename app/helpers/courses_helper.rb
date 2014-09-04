module CoursesHelper
  def date_range course
    "#{course.start_on} ~ #{course.end_on}"
  end
end
