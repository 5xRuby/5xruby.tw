class CampsController < ApplicationController
  def show
    @camp = Activity::Camp.last
    @order = @camp.orders.new
  end
end
