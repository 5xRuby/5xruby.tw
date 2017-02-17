module PostsHelper
  def render_post(post)
    if post.html?
      raw tr(post, :content)
    else
      MarkdownRenderer.render post.content
    end
  end

  POSTS_CATE_TAGS = Settings.posts_cate_tags
  def posts_cate_tags
    POSTS_CATE_TAGS
  end

  def posts_cate_tags_exclude(cate_tags)
    posts_cate_tags - (cate_tags || [])
  end
end
