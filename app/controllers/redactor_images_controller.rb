class RedactorImagesController < ApplicationController
  def create
    @image = RedactorImage.new(image_params)
    if @image.save
      render json: {filelink: @image.image.thumb.url}
    else
      head :bad_request
    end
  end

  private

  def image_params
    params.require(:redactor_image).permit(:image)
  end
end