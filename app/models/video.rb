class Video < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros
  mount_uploader :image, VideoImageUploader

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
end
