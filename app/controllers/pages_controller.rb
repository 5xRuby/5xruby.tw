class PagesController < ApplicationController
  def index
  end

  def contacts
    @contact = Contact.new
  end
end
