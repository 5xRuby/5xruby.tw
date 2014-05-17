# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  content    :text             not null
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#  author_id  :integer
#

class Post < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros
  mount_uploader :image, PostImageUploader

  # association macros
  belongs_to :author

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
