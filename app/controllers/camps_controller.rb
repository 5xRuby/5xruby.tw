class CampsController < ApplicationController
  def show
    @camp = Activity::Camp.last
  end
end
