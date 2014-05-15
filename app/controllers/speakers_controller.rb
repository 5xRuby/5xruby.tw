class SpeakersController < ApplicationController
  def index
    @speakers = Speaker.order(:sort_id)
  end
end
