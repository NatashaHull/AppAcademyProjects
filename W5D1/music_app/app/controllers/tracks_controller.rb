class TracksController < ApplicationController
  before_filter :logged_in?, :activated?

  def index
    @album = Album.find(params[:album_id])
    @tracks = @album.tracks
  end

  def show
    @track = Track.find(params[:id])
    @note = Note.new
  end

  def new
    @track = Track.new(:album_id => params[:album_id])
    @albums = Album.all
  end

  def create
    @track = Track.new(params[:track])
    if @track.save
      redirect_to @track
    else
      @albums = Album.all
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(params[:track])
      redirect_to @track
    else
      @albums = Album.all
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to tracks_url
  end
end
