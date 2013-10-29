class PhotosController < ApplicationController
  def index
    @photos = Photo.where(:owner_id => params[:user_id])

    respond_to do |format|
      format.html
      format.json { render :json => @photos }
    end
  end
end
