module PostsHelper
  def render_post(post)
    if post.html?
      raw tr(post, :content)
    else
      MarkdownRenderer.render post.content
    end
  end
end
