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
        course.is_online ? label_tag('上線', :success) : label_tag('下線')
      }
    ]
  end
end
