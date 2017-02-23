
module IndexPicturesHelper
  def index_pic_set_tag(index_pic, options = {})
    lang = options[:lang] || I18n.locale
    srcset_hash = index_pic.srcset lang
    srcset = srcset_hash.map do |size, src|
      "#{src.url} #{size}"
    end.join(' , ')
    src = index_pic.src(lang)
    image_tag src, {alt: index_pic.alt, srcset: srcset}.merge(options) if src.present?
  end

  def index_pic_set_link_tag(index_pic, link_attrs = {}, options = {})
    if index_pic.href.present?
      link_to raw(index_pic_set_tag(index_pic, options)), index_pic.href, link_attrs
    else
      index_pic_set_tag(index_pic, options)
    end
  end
end
