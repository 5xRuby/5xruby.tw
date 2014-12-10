class RentalController < ApplicationController
  # POST /rental/calculate
  def calculate
    @request = Rental::Request.new params.require(:rental_request)
    render 'rental/request', layout: false
  end
end
