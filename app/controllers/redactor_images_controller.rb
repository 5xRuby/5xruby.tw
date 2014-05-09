class RedactorImagesController < ApplicationController
  def create
    if @image = RedactorImage.create(image_params)
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