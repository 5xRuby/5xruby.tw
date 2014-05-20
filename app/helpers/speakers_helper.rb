module SpeakersHelper
  def speaker_summary speaker
    speaker.summary.to_s.split($/).join('<br>').html_safe
  end
end
