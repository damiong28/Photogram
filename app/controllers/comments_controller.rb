class CommentsController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  
  def index 
    @comments = @post.comments.order("created_at ASC")
    
     respond_to do |format|
      format.html { render layout: !request.xhr? }
    end
  end
  
  def new
    @comment = @post.comments.build
  end
    
  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id =  current_user.id
    
    if @comment.save
      create_notification @post
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js 
      end
    else
      flash.now[:alert] = "Failed to create comment, please check your submission 
                            and try again"
      render new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to(:back)
  end
  
  private
  
  def create_notification(post)
    return if post.user == current_user
    Notification.create(user_id: post.user.id,
                        notified_by_id: current_user.id,
                        post_id: post.id,
                        identifier: @comment.id,
                        notice_type: 'comment')
  end
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def set_comment
    @comment=@post.comments.find(params[:id])
  end
  
  def correct_user
    unless @comment.user.id == current_user.id
      flash[:alert] = "That comment doesn't belong to you!"
      redirect_to :back
    end
  end
end
