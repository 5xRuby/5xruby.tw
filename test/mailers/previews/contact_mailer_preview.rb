class ContactMailerPreview < ActionMailer::Preview
  def enquire
    ContactMailer.enquire Contact.new(
      first_name: '喝鉛', last_name: '喝', email: 'aaa@bbb.ccc', phone: '12345678', message: '呵呵', price: 1
    )
  end
end