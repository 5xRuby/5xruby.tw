class IndexPictureImg < ApplicationRecord
  # scope macros

  # Concerns macros

  # Constants
  
  # Attributes related macros
  mount_uploader :src, IndexPictureImgUploader
  LOCALES = Settings.index_pictures.langs
  SIZES = Settings.index_pictures.sizes
  enum lang: Hash[LOCALES.map {|x| [x.to_sym, x.to_s] }],
    size: Hash[SIZES.map {|x| [x.to_sym, x.to_s] }]

  # association macros
  belongs_to :index_picture

  # validation macros
  validates :src, :lang, :size, presence: true

  # callbacks

  # other

  protected
  # callback methods
end
