class CampsController < ApplicationController
  def index
    @camps = Activity::Camp.online.order(:id)
    @speakers = Speaker.online.includes(:translations).order(:sort_id)
  end

  def show
    @camp = Activity::Camp.find_by_permalink(params[:id])
    @activity_courses = @camp.activity_courses.includes(
      :course, { course: [:translations, :speakers, :stages, { stages: :translations }] }
    ).order(:priority)
    @order = @camp.orders.new
    @speakers = @camp.speakers
    @seo = {
      meta: {
        description: @camp.payload["og"]["desc"]
      },
      google: {
        name: @camp.title,
        description: @camp.payload["og"]["desc"],
        image: @camp.payload["og"]["img"],
        item_type: :Article
      },
      og: {
        title: @camp.title,
        url: request.url,
        type: :website,
        description: @camp.payload["og"]["desc"],
        image: @camp.payload["og"]["img"]
      }
    }

  end

end
