xml.instruct! :xml
xml.rss :version => '2.0' do
  xml.channel do
    xml.title '五倍紅寶石股份有限公司'
    xml.description "五倍紅寶石股份有限公司"
    xml.link posts_url
    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end