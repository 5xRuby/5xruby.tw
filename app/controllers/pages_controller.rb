class PagesController < ApplicationController
  def index
    @next_courses = Course.available.coming.limit(4)
  end

  def contacts
    @contact = Contact.new
  end

  def faq
    @faqs = Faq.where(is_online: true).includes(:translations).order(:sort_id)
  end
end
