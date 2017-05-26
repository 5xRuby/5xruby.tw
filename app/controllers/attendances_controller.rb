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
    @resource = DynamicForm.create(Activity::Camp.last)
  end

  alias build_resource load_resource

  def save_resource
    @resource.assign_attributes(allowed_params)
    byebug
    if @resource.save
      redirect_to root_path
    else
      render :new
    end
  end

  def allowed_params
    params.require(:dynamic_form).permit(*whitelisted)
  end

  def whitelisted
    JSON.parse(Activity::Camp.last.form.fields).map do |q|
      q['as'] != 'check_boxes' ? q['name'].to_sym : { q['name'].to_sym => [] }
    end
  end
end
