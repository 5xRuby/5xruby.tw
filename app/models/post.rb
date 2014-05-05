class Post < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros
  mount_uploader :image, PostImageUploader

  # association macros

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
