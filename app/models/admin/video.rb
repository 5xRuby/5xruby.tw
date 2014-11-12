# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  iframe      :string(255)
#  summary     :string(255)
#  description :text
#  is_online   :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  image       :string(255)
#

class Admin::Video < Video
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  has_and_belongs_to_many :speakers

  # validation macros

  # callbacks

  # other

  protected
  # callback methods
end
