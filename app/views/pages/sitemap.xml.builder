xml.instruct! :xml
xml.urlset xmlns: 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  # pages
  xml.url do
    xml.loc root_url
  end

  xml.url do
    xml.loc about_url
  end

  xml.url do
    xml.loc contacts_url
  end

  xml.url do
    xml.loc faq_url
  end

  # speakers
  xml.url do
    xml.loc speakers_url
  end

  # courses
  xml.url do
    xml.loc courses_url
  end
  Course.find_each do |course|
    xml.url do
      xml.loc course_url(course)
      xml.lastmod course.updated_at.to_date
    end
  end

  # posts
  xml.url do
    xml.loc posts_url
  end
  Post.find_each do |post|
    xml.url do
      xml.loc post_url(post)
      xml.lastmod post.updated_at.to_date
    end
  end
end