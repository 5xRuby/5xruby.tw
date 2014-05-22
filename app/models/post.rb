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
#  summary    :string(255)
#

class Post < ActiveRecord::Base
  # scope macros

  # Concerns macros
  acts_as_taggable

  # Constants
  
  # Attributes related macros
  mount_uploader :image, PostImageUploader

  # association macros
  belongs_to :author

  # validation macros
  validates :summary, length: {maximum: 150}

  # callbacks

  # other

  protected
  # callback methods
end
