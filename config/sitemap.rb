# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://5xruby.tw"
SitemapGenerator::Sitemap.search_engines if Rails.env.production?

SitemapGenerator::Sitemap.create do
  [nil, 'en', 'ja'].each do |locale|
    # Static Pages
    Settings.alias.each do |path|
      add send("#{path.from.gsub('/', '_')}_path", locale)
    end

    add privacy_policy_path(locale)
    add terms_of_service_path(locale)

    # Dynamic Pages
    add showcases_path(locale)

    add posts_path(locale), changefreq: 'daily'
    Post.find_each do |post|
      add post_path(locale, post), lastmod: post.updated_at
    end

    add talks_path(locale)
    Activity::Talk.find_each do |talk|
      add talk_path(locale, talk), lastmod: talk.updated_at
    end

    add camps_path(locale)
    Activity::Camp.find_each do |camp|
      add camp_path(locale, camp), lastmod: camp.updated_at
    end
  end
end
