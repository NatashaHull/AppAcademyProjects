class AlbumsController < ApplicationController
  before_filter :logged_in?, :activated?

  def index
    @band = Band.find(params[:band_id])
    @albums = @band.albums
  end

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new(:band_id => params[:band_id])
    @bands = Band.all
  end

  def create
    @album = Album.new(params[:album])
    if @album.save
      redirect_to @album
    else
      @bands = Band.all
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(params[:album])
      redirect_to @album
    else
      @bands = Band.all
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to albums_url
  end
end
