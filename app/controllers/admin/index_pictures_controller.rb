class Admin::IndexPicturesController < AdminController

  protected
  
  def current_model
    Admin::IndexPicture
  end

  def allowed_params
    params.require(:admin_index_picture).permit(:alt, :href, index_picture_imgs_attributes: %i[id _destroy src size lang])
  end
end
