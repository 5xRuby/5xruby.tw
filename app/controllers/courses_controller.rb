class CoursesController < ApplicationController
  def index
    @courses = Course.order('id DESC').page(params[:page]).per(6)
    @courses = @courses.where(category: @category) if @category = Category.find_by(id: params[:category_id])
    @categories = Category.where('courses_count > ?', 0)
  end

  def show
    @course = Course.includes(:schedules).find(params[:id])
  end
end
