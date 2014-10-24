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
#

class Video < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros

  # association macros
  has_and_belongs_to_many :speakers
  has_many :translations, as: :translatable

  # validation macros

  # callbacks

  # other
  def next
    self.class.where('id > ?', id).first
  end

  def previous
    self.class.where('id < ?', id).last
  end

  protected
  # callback methods
end
