class PagesController < ApplicationController
  def index
    @next_schedules = Schedule.includes(stage: :course).available.limit(4)
  end

  def contacts
    @contact = Contact.new
  end

  def faq
    @faqs = Faq.where(is_online: true).order(:sort_id)
  end
end
