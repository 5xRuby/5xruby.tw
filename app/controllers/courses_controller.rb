class CoursesController < ApplicationController
  def index
    @courses = Course.order('id DESC').search(params).page(params[:page]).per(6)
    @categories = Category.includes(:courses)
  end

  def show
    @course = Course.includes(:schedules).find(params[:id])
  end
end
