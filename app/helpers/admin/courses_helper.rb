module Admin::CoursesHelper
  def tr_speakers record
    [
      :speakers,
      ->(record){
        record.speakers.map{ |speaker| link_to speaker.name, speaker }.join(', ').html_safe
      }
    ]
  end
end
