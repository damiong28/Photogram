class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]
  
          
  def index  
    @posts = Post.all.order('created_at DESC').page params[:page]
    
    respond_to do |format|
      format.js
      format.html
    end
  end  
      
  def new
    @post = current_user.posts.build
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created"
      redirect_to posts_path
    else
      flash.now[:alert] = "Failed to create post, please check your submission 
                            and try again"
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    @post.update(post_params)
    if @post.save
      flash[:success] = "Post edited"
      redirect_to @post
    else
      flash.now[:alert] = "Failed to edit post, please check your submission and try again"
      render 'edit'
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to posts_path
  end
  
  def like
    if @post.liked_by current_user
      create_notification @post
        respond_to do |format|
          format.js
          format.html { redirect_to :back }
      end
    end
  end
  
  def unlike
    if @post.unliked_by current_user
      respond_to do |format|
        format.js
        format.html { redirect_to :back }
      end
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:image, :caption)
  end
  
  def set_post
    @post=Post.find(params[:id])
  end
  
  def correct_user
    unless @post.user.id == current_user.id
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end
  
  def create_notification(post)
    return if post.user == current_user
    Notification.create(user_id: post.user.id,
                        notified_by_id: current_user.id,
                        post_id: post.id,
                        identifier: post.id,
                        notice_type: 'like')
  end
end
