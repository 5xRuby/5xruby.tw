# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://5xruby.tw"
SitemapGenerator::Sitemap.search_engines if Rails.env.production?

SitemapGenerator::Sitemap.create do
  locale = nil
  # Static Pages
  Settings.alias.each do |path|
    add send("#{path.from.gsub('/', '_')}_path", locale)
  end

  # PagesController
  [:privacy_policy, :terms_of_service, :showcases, :press, :space, :training, :about, :members, :contacts, :faq].each do |prefix|
    add send("#{prefix.to_s}_path", locale)
  end

  add posts_path(locale), changefreq: 'daily'
  Post.online.publish.order('publish_at DESC').includes(:translations, :author, :tags).find_each do |post|
    add post_path(locale, post), lastmod: post.updated_at
  end

  add talks_path(locale)
  Activity::Talk.includes(courses: [:translations, :category, :stages]).online.order(id: :desc).find_each do |talk|
    add talk_path(locale, talk), lastmod: talk.updated_at
  end

  add camps_path(locale)

  #Activity::Camp.online.order(:id).find_each do |camp|
  #  add camp_path(locale, camp), lastmod: camp.updated_at
  #end
end
