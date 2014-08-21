class PagesController < ApplicationController
  def index
    @next_schedules = Schedule.includes(stage: :course).available.where(courses: {is_online: true}).where(stages: {sort_id: 1110}).limit(4)
  end

  def contacts
    @contact = Contact.new
  end

  def faq
    @faqs = Faq.where(is_online: true).order(:sort_id)
  end
end
