class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
        
  def index
    @posts = Post.all
  end
      
  def new
    @post = Post.new
  end
  
  def create
    if @post = Post.create(post_params)
      flash[:success] = "Post created"
      redirect_to posts_path
    else
      flash.now[:alert] = "Failed to create post, please check your submission and try again"
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      flash[:success] = "Post edited"
      redirect_to @post
    else
      flash.now[:alert] = "Failed to edit post, please check your submission and try again"
      render 'edit'
    end
  end
  
  def destroy
    if @post.destroy
      flash[:success] = "Post deleted"
      redirect_to posts_path
    else
      flash.now[:alert] = "Failed to delete post, please try again"
      render 'edit'
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:image, :caption)
  end
  
  def set_post
    @post=Post.find(params[:id])
  end
end
