class PostsController < ApplicationController
  def index
    @posts = Post.order('id DESC').page(params[:page]).per(3)
  end

  def show
    @post = Post.find(params[:id])
  end
end
