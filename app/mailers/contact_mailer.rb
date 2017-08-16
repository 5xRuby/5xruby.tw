class ContactMailer < ActionMailer::Base
  # default from: "from@example.com"
  def enquire contact
    @contact = contact
    mail to: Settings.contact_email, from: contact.email, sender: Settings.action_mailer.default_options.from
  end
end
