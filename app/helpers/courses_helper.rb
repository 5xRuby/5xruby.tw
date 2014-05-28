module CoursesHelper
  # [obj] can be an instance of Course or Schedule
  def apply_url obj, **options
    if course = case obj
      when Course then obj
      when Schedule then obj.stage.course
      end
      course.apply_link.presence || new_course_apply_path(course, **options)
    end
  end
end