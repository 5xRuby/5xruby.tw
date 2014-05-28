class PostsController < ApplicationController
  before_action :set_recent_posts, :set_tags

  def index
    respond_to do |format|
      format.html do
        @posts = Post.online.order('id DESC').page(params[:page]).per(3)
        @query_tags = params[:tags].is_a?(String) ? params[:tags].split(',') : params[:tags]
        @posts = @posts.tagged_with(@query_tags) if @query_tags.present?
      end
      format.rss do
        @posts = Post.online.order('id DESC').first(10)
        render content_type: 'application/rss+xml'
      end
    end
  end

  def show
    @post = Post.online.find_by!(permalink: params[:id])
    @seo = {
      meta: {
        description: @post.summary,
        author: @post.author.try(:name)
      },
      google: {
        name: @post.title,
        description: @post.summary,
        image: @post.image_url,
        item_type: :Article
      },
      og: {
        title: @post.title,
        url: post_url(@post),
        type: :website,
        description: @post.summary,
        image: @post.image_url
      }
    }
  end

  private

  def set_recent_posts
    @recent_posts = Post.online.order('id DESC').limit(3)
  end

  def set_tags
    @tags = Post.online.tags_on(:tags)
  end
end
