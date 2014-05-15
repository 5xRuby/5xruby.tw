class SpeakersController < ApplicationController
  def index
    @speakers = Speaker.order('id DESC')
  end
end
