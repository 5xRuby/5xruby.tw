module StagesHelper
  def time_range stage
    "#{stage.start_at.strftime("%H:%M")} ~ #{stage.end_at.strftime("%H:%M")}"
  end
end