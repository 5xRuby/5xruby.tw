class AttendancesController < ApplicationController
  def new
    build_resource
  end

  def create
    load_resource
    save_resource
  end

  private

  def load_resource
    @resource = DynamicForm.create(current_activity)
  end

  alias build_resource load_resource

  def save_resource
    @resource.assign_attributes(allowed_params)
    if @resource.save
      redirect_to root_path
    else
      render :new
    end
  end

  def allowed_params
    params.require(:dynamic_form).permit(*whitelisted, :purchasable_id)
  end

  def whitelisted
    JSON.parse(current_activity.form.fields).map do |q|
      q['as'] != 'check_boxes' ? q['name'].to_sym : { q['name'].to_sym => [] }
    end
  end

  def current_activity
    @current_activity ||= Activity.find_by(id: params[:purchasable_id]) || Activity::Camp.last
  end
end
