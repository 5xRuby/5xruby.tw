module SpeakersHelper
  def speaker_summary speaker
    tr(speaker, :summary).to_s.split($/).join('<br>').html_safe
  end
end
