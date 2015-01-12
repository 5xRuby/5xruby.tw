class Showcase < ActiveRecord::Base
  # scope macros

  # Concerns macros

  # Constants

  # Attributes related macros
  mount_uploader :image, ShowcaseImageUploader

  # association macros
  has_many :translations, as: :translatable

  # validation macros

  # callbacks

  # other
end
