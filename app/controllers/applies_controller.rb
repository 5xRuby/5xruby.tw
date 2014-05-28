class AppliesController < ApplicationController
  before_action :set_course

  def new
    @apply = @course.applies.new (params[:apply] && apply_params)
  end

  def create
    @apply = @course.applies.new(apply_params)
    if @apply.valid? && recaptcha? && @apply.save
      ApplyMailer.notify_user(@apply).deliver
      ApplyMailer.notify_5xruby(@apply).deliver
      redirect_to submit_course_applies_path(@course)
    else
      if recaptcha?
        flash.now[:alert] = t('.something_went_wrong')
      else
        flash.now[:alert] = t('errors.messages.captcha_not_passed')
        @apply.errors.add(:base, :captcha_not_passed)
      end
      render :new
    end
  end

  def submit
  end

  private

  def set_course
    @course = Course.find_by!(permalink: params[:course_id])
  end

  def apply_params
    params.require(:apply).permit(:course_id, :stage_id, :schedule_id, :first_name, :last_name, :phone, :email, :age, :gender, :message)
  end
end
