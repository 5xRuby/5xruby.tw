module SeoHelper
  def seo_meta_tags
    meta_tags(@seo[:meta]) + og_meta_tags(@seo[:og]) + google_meta_tags(@seo[:google]) if @seo
  end

  private

  # http://ogp.me/
  def og_meta_tags **hash
    meta_tags(hash){|name, value| tag(:meta, property: "og:#{name}", content: value) }
  end

  # http://schema.org/
  def google_meta_tags **hash
    hash.delete :item_type
    meta_tags(hash){|name, value| tag(:meta, itemprop: name, content: value) }
  end

  # def twitter_meta_tags hash = {}
  #   hash = hash.presence || @seo_twitter
  #   meta_tags(hash){|name, value| tag(:meta, name: "twitter:#{name}", content: value) }
  # end

  def meta_tags **hash, &block
    hash.map{ |name, value|
      value = image_url(value) if name == :image
      block_given? ? yield(name, value) : tag(:meta, name: name, content: value)
    }.inject(&:+) if hash.respond_to?(:map)
  end
end