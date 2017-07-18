class CampsController < ApplicationController
  def index
    @camp = Activity::Camp.last
    @courses = @camp.courses.includes(:translations, { speakers: [:translations] }, { stages: [:translations] } )
    @order = @camp.orders.new
  end

  def show
    @camp = Activity::Camp.find_by_permalink(params[:id])
    @courses = @camp.courses.includes(:translations, { speakers: [:translations] }, { stages: [:translations] } )
    @order = @camp.orders.new
  end
end
