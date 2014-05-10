class PagesController < ApplicationController
  def index
    @recent_courses = Course.order('id DESC').limit(4)
  end

  def contacts
    @contact = Contact.new
  end
end
