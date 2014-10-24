class SpeakersController < ApplicationController
  def index
    @speakers = Speaker.online.includes(:translations).order(:sort_id)
  end
end
