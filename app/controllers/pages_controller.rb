class PagesController < ApplicationController
  def index
    @next_courses = Course.available.coming.limit(3)
    @showcases = Showcase.includes(:translations).where(is_online: true).order(:sort_id).first 3
  end

  def contacts
    @contact = Contact.new
  end

  def faq
    @faqs = Faq.where(is_online: true).includes(:translations).order(:sort_id)
  end
end
