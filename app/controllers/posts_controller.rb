class PostsController < ApplicationController
        
  def index
    @posts = Post.all
  end
      
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.create(post_params)
    redirect_to posts_path
  end
  
  def show
    @post = Post.find_by(params[:id])
  end
  
  def edit
    @post = Post.find_by(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "Post edited"
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:image, :caption)
  end
end
