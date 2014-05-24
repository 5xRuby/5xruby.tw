class SpeakersController < ApplicationController
  def index
    @speakers = Speaker.online.order(:sort_id)
  end
end
