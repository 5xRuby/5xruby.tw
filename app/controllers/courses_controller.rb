class CoursesController < ApplicationController
  def index
    @courses = Course.online.order('id DESC').page(params[:page]).per(6)
    @courses = @courses.where(category: @category) if @category = Category.find_by(id: params[:category_id])
    @categories = Category.order(:sort_id).where('courses_count > ?', 0)
  end

  def show
    @course = Course.online.includes(:schedules).find(params[:id])
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
end
