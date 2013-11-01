class StarsController < ApplicationController
  def create
    @star = Star.new(:gist_id => params[:id])
    @star.user_id = current_user.id

    if @star.save
      render :json => @star
    else
      render :json => @star.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def destroy
    @star = Star.find_by_user_id_and_gist_id(current_user.id, params[:id])
    @star.destroy
    render :json => @star
  end

  def index
    render :json => current_user.starred_gists
  end
end
