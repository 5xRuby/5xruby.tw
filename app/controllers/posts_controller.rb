class PostsController < ApplicationController
  include PostViewable
  before_action :set_recent_posts, :set_tags

  def index
    respond_to do |format|
      format.html do
        @posts = Post.online.publish.order('publish_at DESC').includes(:translations, :author, :tags).page(params[:page]).per(3)
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
    @post = Post.includes(:translations).online.find_by!(permalink: params[:id])
    @seo = {
      meta: {
        description: tr(@post, :summary),
        author: @post.author.try(:name)
      },
      google: {
        name: tr(@post, :title),
        description: tr(@post, :summary),
        image: @post.image_url,
        item_type: :Article
      },
      og: {
        title: tr(@post, :title),
        url: post_url(@post),
        type: :website,
        description: tr(@post, :summary),
        image: @post.image_url,
        :"image:width" => @post.image_width,
        :"image:height" => @post.image_height
      }
    }
  end

  private

end
