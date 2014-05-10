class PagesController < ApplicationController
  def index
    @next_schedules = Schedule.available.limit(4)
  end

  def contacts
    @contact = Contact.new
  end
end
