class SchedulesController < ApplicationController
  def show
    @schedule = Schedule.includes(stage: :course, events: :speaker).find(params[:id])
  end
end
