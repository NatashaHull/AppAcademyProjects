class BandsController < ApplicationController
  before_filter :logged_in?, :activated?
  before_filter :admin?, :except => [:index, :show]

  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
    @albums = @band.albums.includes(:tracks)
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(params[:band])
    if @band.save
      redirect_to @band
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(params[:band])
      redirect_to @band
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end
end
