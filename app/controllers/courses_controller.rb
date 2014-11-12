class CoursesController < ApplicationController
  def index
    @courses = Course.includes(:translations, :category, :stages).online.magic_scope.page(params[:page]).per(6)
    @courses = @courses.where(category: @category) if @category = Category.find_by(permalink: params[:category])
    @categories = Category.includes(courses: :stages).available.order(:sort_id)
  end

  def show
    @course = Course.includes(:translations, :stages).online.find_by!(permalink: params[:id])
    @seo = {
      meta: {
        description: tr(@course, :summary)
      },
      google: {
        name: tr(@course, :title),
        description: tr(@course, :summary),
        image: @course.image_url,
        item_type: :Article
      },
      og: {
        title: tr(@course, :title),
        url: course_url(@course),
        type: :website,
        description: tr(@course, :summary),
        image: @course.image_url
      }
    }
  end
end
