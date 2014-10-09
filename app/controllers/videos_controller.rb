class VideosController < ApplicationController
  def index
    @videos = Video.where(is_online: true).page(params[:page])
  end

  def show
    @video = Video.find(params[:id])
  end
end
