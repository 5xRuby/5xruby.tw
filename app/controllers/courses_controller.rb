class CoursesController < ApplicationController
  before_action :set_course, only: %i[redirect show]  

  def index
    @courses = Course.available.coming.page(params[:page]).per(6)
    @courses = @courses.where(category: @category) if @category = Category.find_by(permalink: params[:category])
    @categories = Category.order(:sort_id).includes(:courses).where(courses: {is_online: true})
  end

  def redirect
    redirect_to @course
  end

  def show
    @seo = {
      meta: {
        description: @course.summary
      },
      google: {
        name: @course.title,
        description: @course.summary,
        image: @course.image_url,
        item_type: :Article
      },
      og: {
        title: @course.title,
        url: course_url(@course),
        type: :website,
        description: @course.summary,
        image: @course.image_url
      }
    }
  end

  private

  def set_course
    @course = Course.online.includes(:stages).find_by!(permalink: params[:id])
  end
end
