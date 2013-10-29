class Api::PhotosController < ApplicationController
  before_filter :require_current_user!

  def create
    @photo = Photo.new(params[:photo])
    @photo.owner_id = current_user.id

    if @photo.save
      render :json => @photo
    else
      render :json => @photo, :status => :unprocessable_entity
    end
  end

  def update
    @photo = Photo.find(params[:id])

    if @photo.update_attributes(params[:photo])
      render :json => @photo
    else
      render :json => @photo, :status => :unprocessable_entity
    end
  end
end
