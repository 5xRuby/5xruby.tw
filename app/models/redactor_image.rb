# == Schema Information
#
# Table name: redactor_images
#
#  id         :integer          not null, primary key
#  image      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class RedactorImage < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros
  mount_uploader :image, RedactorImageUploader

  # association macros

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
