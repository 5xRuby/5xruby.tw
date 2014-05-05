class PostsController < ApplicationController
  before_action :set_recent_posts

  def index
    @posts = Post.order('id DESC').page(params[:page]).per(3)
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def set_recent_posts
    @recent_posts = Post.order('id DESC').limit(3)
  end
end
