# == Schema Information
#
# Table name: speakers
#
#  id         :integer          not null, primary key
#  avatar     :string(255)
#  name       :string(255)      not null
#  summary    :text
#  is_online  :boolean          default(FALSE), not null
#  created_at :datetime
#  updated_at :datetime
#

class Speaker < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros
  mount_uploader :avatar, SpeakerAvatarUploader

  # association macros

  # validation macros
  validates :name, presence: true

  # callbacks

  # other

  protected
  # callback methods
end
