class TalksController < ApplicationController
  def index
    @talks = Activity::Talk.includes(courses: [:translations, :category, :stages]).online.order('id DESC').page(params[:page]).per(6)
    @talks = @talks.with_category(@category) if @category = Category.find_by(permalink: params[:category])
    @categories = Category.with_max_date.order(:sort_id)
    @speakers = Speaker.online.includes(:translations).order(:sort_id)
  end

  def show
    @talk = Activity::Talk.includes(courses: [:translations, :stages]).online.find_by!(permalink: params[:id])
    @seo = {
      meta: {
        description: tr(@talk.course, :summary)
      },
      google: {
        name: tr(@talk, :title),
        description: tr(@talk.course, :summary),
        image: @talk.course.image_url,
        item_type: :Article
      },
      og: {
        title: tr(@talk, :title),
        url: talk_url(@talk),
        type: :website,
        description: tr(@talk.course, :summary),
        image: @talk.course.image_url
      }
    }
  end
end
