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
#  summary    :text
#  is_online  :boolean          default(FALSE), not null
#  permalink  :string(255)      default("f58dcb51"), not null
#  publish_at :datetime
#

class Post < ActiveRecord::Base
  # scope macros
  scope :online, -> { where(is_online: true) }
  scope :publish, -> { where('publish_at < ?', Time.now) }

  # Concerns macros
  acts_as_taggable
  include Permalinkable

  # Constants

  # Attributes related macros
  mount_uploader :image, PostImageUploader
  permalinkable :title

  # association macros
  belongs_to :author

  # validation macros
  validates :summary, length: {maximum: 150}

  # callbacks

  # other

  protected
  # callback methods
end
