module CoursesHelper
  # [obj] can be an instance of Course or Schedule
  def apply_link obj
    case obj
    when Course then obj.apply_link.presence || new_course_apply_path(obj)
    when Schedule then obj.stage.course.apply_link.presence || new_course_apply_path(obj.stage.course, apply: {stage_id: obj.stage.id, schedule_id: obj.id})
    end
  end
end