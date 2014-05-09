class CoursesController < ApplicationController
  def index
    @courses = Course.order('id DESC').page(params[:page]).per(6)
  end

  def show
    @course = Course.find(params[:id])
  end
end
