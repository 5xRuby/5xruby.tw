module TalksHelper
  def date_range(resource)
    "#{resource.start_on} ~ #{resource.end_on}"
  end

  def speakers_name(resource)
    resource.speakers.map do |s|
      tr(s, :name)
    end.join(', ')
  end
end
