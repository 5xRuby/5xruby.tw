module CoursesHelper
  def date_range course
    "#{course.start_on} ~ #{course.end_on}"
  end

  def speakers_name(course)
    course.speakers.map do |s|
      tr(s, :name)
    end.join(', ')
  end
end
