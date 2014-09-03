module Admin::CoursesHelper
  def tr_speakers course
    [
      :speakers,
      ->(course){
        course.speakers.map{ |speaker| link_to speaker.name, speaker }.join(', ').html_safe
      }
    ]
  end
end
