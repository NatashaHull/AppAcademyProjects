class FollowingsController < ApplicationController
  before_filter :logged_in?

  def create
    @following = Follow.new(params[:following])
    @following.follower_id = current_user.id
    if @following.save
      redirect_to users_url
    else
      flash[:errors] = @following.errors.full_messages
      redirect_to users_url
    end
  end

  def destroy
    @following = Follow.find_by_followee_id_and_follower_id(
      params[:following], follower_id => current_user.id
      )
  end
end
