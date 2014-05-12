class ApplyPreview < ActionMailer::Preview
  def notify_user
    ApplyMailer.notify_user(Apply.first)
  end
  def notify_5xruby
    ApplyMailer.notify_5xruby(Apply.first)
  end
end