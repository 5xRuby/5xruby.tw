class AppliesController < ApplicationController
  before_action :set_course

  def new
    @apply = @course.applies.new
  end

  def create
    @apply = @course.applies.new(apply_params)
    if @apply.save
      redirect_to @course
    else
      render :new
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def apply_params
    params.require(:apply).permit(:course_id, :stage_id, :schedule_id, :first_name, :last_name, :phone, :email, :age, :gender, :message)
  end
end
