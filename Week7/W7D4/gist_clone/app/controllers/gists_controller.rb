class GistsController < ApplicationController
  before_filter :require_current_user!, :except => [:show]

  def index
    render :json => current_user.gists, :user_id => current_user.id
  end

  def show
    if !!current_user
      render :json => Gist.find(params[:id]), :user_id => current_user.id
    else
      render :json => Gist.find(params[:id])
    end
  end

  def create
    @gist = Gist.new(params[:gist])
    @gist.user_id = current_user.id

    if @gist.save
      render :json => @gist, :user_id => current_user.id
    else
      render :json => @gist.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def update
    @gist = Gist.find(params[:id])

    if @gist.update_attributes(params[:gist])
      render :json => @gist
    else
      render :json => @gist.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def destroy
    @gist = Gist.find(params[:id])
    @gist.destroy
    render :json => @gist
  end
end
