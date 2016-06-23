class ProfilesController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @posts = User.find_by(username: params[:username]).posts.order('created_at DESC')
  end
  
  def edit
  end
  
  def update
    @user.update(profile_params)
    if @user.save
      flash[:success] = "Profile updated"
      redirect_to profile_path(@user.username)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end
  
  private
  
    def set_user
      @user = User.find_by(username: params[:username])
    end
  
    def profile_params
      params.require(:user).permit(:avatar, :bio)
    end
  
    def correct_user
      
      unless current_user == @user
        flash[:alert]="That profile doesn't belong to you!"
        redirect_to root_path
      end
    end
  
end
