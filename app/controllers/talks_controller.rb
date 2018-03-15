class TalksController < ApplicationController

  breadcrumb I18n.t('breadcrumb.home'), :root_path
  breadcrumb I18n.t('breadcrumb.talks'), :talks_path

  def index
    @talks = Activity::Talk.includes(courses: [:translations, :category, :stages]).online.order(id: :desc).page(params[:page]).per(6)
    @talks = @talks.with_category(@category) if @category = Category.find_by(permalink: params[:category])
    @categories = Category.with_max_date.order(:sort_id)
    @speakers = Speaker.online.includes(:translations).order(:sort_id)
  end

  def show
    @talk = Activity::Talk.includes(courses: [:translations, :stages]).online.find_by!(permalink: params[:id])
    breadcrumb @talk.title, nil
    @seo = {
      meta: {
        description: tr(@talk.course, :summary)
      },
      google: {
        name: tr(@talk, :title),
        description: tr(@talk.course, :summary),
        image: @talk.image_url,
        item_type: :Course,
        provider: "5xRuby"
      },
      og: {
        title: tr(@talk, :title),
        url: talk_url(@talk),
        type: :website,
        description: tr(@talk.course, :summary),
        image: @talk.image_url
      }
    }
  end
end
