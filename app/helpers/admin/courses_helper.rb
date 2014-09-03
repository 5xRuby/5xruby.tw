module Admin::CoursesHelper
  def tr_speakers course
    [
      :speakers,
      ->(course){
        course.speakers.map{ |speaker| link_to speaker.name, speaker }.join(', ').html_safe
      }
    ]
  end

  def td_is_online course
    [
      :is_online,
      ->(course){
        course.is_online ? link_to(
          admin_label_tag('上線', :success),
          admin_course_path(course, ref: admin_courses_path, admin_course: {is_online: false}), method: :put)
        : link_to(
          admin_label_tag('下線'),
          admin_course_path(course, ref: admin_courses_path, admin_course: {is_online: true}), method: :put)
      }
    ]
  end
end
