module PostViewable
  def set_recent_posts
    @recent_posts = Post.online.order('id DESC').limit(3)
  end

  def set_tags
    @tags = Post.online.tags_on(:tags)
  end
end
