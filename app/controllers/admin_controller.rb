class AdminController < ApplicationController
  http_basic_authenticate_with Settings.http_basic_auth.to_h if Rails.env.production?
  def space_price
    @rental_request = Rental::Request.new
    @rental_request.days = [Rental::Day.new, Rental::Day.new]
  end
end
