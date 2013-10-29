class Api::PhotosTaggingsController < ApplicationController
  before_filter :require_current_user!
  before_fiter :require_owner!, :only => [:create]

  def index
    @photo_taggings = PhotoTaggings.find_by_photo_id(params[:photo_id])
    render :json => @photo_taggings
  end

  def create
    @photo_taggings = #something
  end

  private

    def require_owner!
      @photo = Photo.find(params[:photo_id])
      unless(@photo.owner_id == current_user.id)
        redirect_to @photo
      end
    end
end
