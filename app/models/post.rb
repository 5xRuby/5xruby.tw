class Post < ActiveRecord::Base
  AVAILABLE_MARKUP_TYPES = %w{html markdown}
  # scope macros
  scope :online, -> { where(is_online: true) }
  scope :publish, -> { where('publish_at < ?', Time.now) }

  enum markup_type: {html: 'html', markdown: 'markdown'}

  %w{content_html content_markdown}.each do |atr|
    define_method atr do
      self.content
    end
    define_method "#{atr}=" do |v|
      self.content = v
    end
  end

  # Concerns macros
  acts_as_taggable
  include Permalinkable

  # Constants

  # Attributes related macros
  mount_uploader :image, PostImageUploader
  permalinkable :title

  # association macros
  belongs_to :author
  has_many :translations, as: :translatable

  # validation macros
  validates :summary, length: {maximum: 150}
  validates_format_of :permalink, with: /\A\w[-|\w|\d]+\z/

  # callbacks

  # other
end
