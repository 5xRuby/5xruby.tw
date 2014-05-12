class ApplyMailer < ActionMailer::Base
  def notify_user apply
    @apply = apply
    mail to: @apply.email, from: Settings.contact_email
  end

  def notify_5xruby apply
    @apply = apply
    mail to: Settings.contact_email, from: 'no-reply@5xruby.tw'
  end
end
