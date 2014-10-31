class VideosController < ApplicationController
  def index
    @videos = Video.includes(:translations).where(is_online: true).order(id: :desc).page(params[:page]).per(9)
  end

  def show
    @video = Video.find(params[:id])
    @next = @video.next
    @previous = @video.previous
    @seo = {
      meta: {
        description: @video.summary
      },
      google: {
        name: @video.title,
        description: @video.summary,
        item_type: :VideoObject
      },
      og: {
        title: @video.title,
        url: video_url(@video),
        type: :'video.episode',
        description: @video.summary
      }
    }
  end
end
