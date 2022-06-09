class RelationshipsController < ApplicationController
  def followes
    @user = User.find(params[:user_id])
    @followes = @user.followes.all
  end

  def followers
    @user = User.find(params[:user_id])
    @followers = @user.followers.all
  end
  
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  
end
