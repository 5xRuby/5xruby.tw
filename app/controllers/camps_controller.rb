class CampsController < ApplicationController
  def show
    @camp = Activity::Camp.last
    @courses = @camp.courses.includes(:translations, { speakers: [:translations] }, { stages: [:translations] } )
    @order = @camp.orders.new
  end
end
