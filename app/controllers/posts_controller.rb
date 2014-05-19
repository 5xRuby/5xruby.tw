class PostsController < ApplicationController
  before_action :set_recent_posts, :set_tags

  def index
    @posts = Post.order('id DESC').page(params[:page]).per(3)
    @query_tags = params[:tags].is_a?(String) ? params[:tags].split(',') : params[:tags]
    @posts = @posts.tagged_with(@query_tags) if @query_tags.present?
  end

  def show
    @post = Post.find(params[:id])
    description = ActionController::Base.helpers.strip_tags(MarkdownRenderer.render(@post.content)).truncate(150)
    @seo = {
      meta: {
        description: description,
        author: @post.author.try(:name)
      },
      google: {
        name: @post.title,
        description: description,
        image: @post.image_url,
        item_type: :Article
      },
      og: {
        title: @post.title,
        url: post_url(@post),
        type: :website,
        description: description,
        image: @post.image_url
      }
    }
  end

  private

  def set_recent_posts
    @recent_posts = Post.order('id DESC').limit(3)
  end

  def set_tags
    @tags = Post.tags_on(:tags)
  end
end
