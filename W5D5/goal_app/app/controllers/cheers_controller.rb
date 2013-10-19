class CheersController < ApplicationController
  def create
    @cheer = Cheer.new(:goal_id => params[:goal_id])
    @cheer.user_id = current_user.id
    if @cheer.save
      redirect_to goal_url(params[:goal_id])
    else
      flash[:errors] = @cheer.errors.full_messages
      redirect_to goal_url(params[:goal_id])
    end
  end

  def destroy
    @cheer = Cheer.find(params[:id])
    @cheer.destroy
    redirect_to goal_url(@cheer.goal_id)
  end
end
