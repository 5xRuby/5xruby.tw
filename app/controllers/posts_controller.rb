class PostsController < ApplicationController
  before_action :set_recent_posts, :set_tags

  def index
    @posts = Post.order('id DESC').page(params[:page]).per(3)
    @query_tags = params[:tags].is_a?(String) ? params[:tags].split(',') : params[:tags]
    @posts = @posts.tagged_with(@query_tags) if @query_tags.present?
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def set_recent_posts
    @recent_posts = Post.order('id DESC').limit(3)
  end

  def set_tags
    @tags = Post.tags_on(:tags)
  end
end
