class IndexPicture < ApplicationRecord
  # scope macros
  scope :lang, -> (lang) {
    includes(:index_picture_imgs).where(index_picture_imgs: {lang: lang})
  }

  # Concerns macros

  # Constants
 
  # Attributes related macros
  DEFAULT_SIZE = Settings.index_pictures.default_size.to_sym
  def src(lang, size = DEFAULT_SIZE)
    return nil if (src_sizes = srcset(lang)).blank?
    if (src_expected = src_sizes[size]).present?
      src_expected
    else
      src_sizes.first[1]
    end
  end

  def srcset(lang)
    lang == :any ? srcs.first[1] : srcs[lang]
  end

  def has_lang?(lang)
    srcs[lang].present?
  end

  def srcs
    if @srcs.nil?
      @srcs = {}
      index_picture_imgs.each do |i|
        @srcs[i.lang.to_sym] ||= {}
        @srcs[i.lang.to_sym][i.size.to_sym] = i.src
      end
      @srcs
    else
      @srcs
    end
  end

  # association macros
  has_many :index_picture_imgs, dependent: :destroy
  accepts_nested_attributes_for :index_picture_imgs, allow_destroy: true

  # validation macros
  validates :index_picture_imgs, presence: true

  # callbacks

  # other

  protected
  # callback methods
end
