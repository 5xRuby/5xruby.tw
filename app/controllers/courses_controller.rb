class CoursesController < ApplicationController
  def index
    @category = Category.find_by(id: params[:category_id])
    @courses = Course.order('id DESC').search(params).page(params[:page]).per(6)
    @categories = Category.includes(:courses)
  end

  def show
    @course = Course.includes(:schedules).find(params[:id])
  end
end
