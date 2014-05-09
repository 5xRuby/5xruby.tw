class ContactMailer < ActionMailer::Base
  # default from: "from@example.com"
  def enquire contact
    @contact = contact
    mail to: 'hi@5xruby.tw', from: contact.email
  end
end
