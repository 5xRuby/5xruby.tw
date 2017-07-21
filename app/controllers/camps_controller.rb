class CampsController < ApplicationController
  def index
    @camps = Activity::Camp.online
    @speakers = Speaker.online.includes(:translations).order(:sort_id)
  end

  def show
    @camp = Activity::Camp.find_by_permalink(params[:id])
    @activity_courses = @camp.activity_courses.includes(:course, { course: [:translations, { speakers: [:translations] }, { stages: [:translations] }] })
    @order = @camp.orders.new
    @speakers = Speaker.online.includes(:translations).order(:sort_id)
  end
end
