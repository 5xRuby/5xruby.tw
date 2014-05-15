class SpeakersController < ApplicationController
  def index
    @speakers = Speaker.order(:sort_id).where(is_online: true)
  end
end
