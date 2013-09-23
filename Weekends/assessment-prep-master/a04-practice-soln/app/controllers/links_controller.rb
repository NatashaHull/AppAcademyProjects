class LinksController < ApplicationController
  before_filter :authenticate
  
  def index
    @links = Link.all
  end

  def show
    @link = Link.find_by_id(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    if @link.save
      redirect_to link_url(@link)
    else
      flash[:errors] = @link.errors.full_messages
      render :new
    end
  end
  
  def edit
    @link = Link.find_by_id(params[:id])
  end
  
  def update
    @link = Link.find_by_id(params[:id])
    if @link.update_attributes(params[:link])
      redirect_to link_url(@link)
    else
      flash[:errors] = @link.errors.full_messages
      render :edit
    end
  end
  
  def destroy
    link = Link.find_by_id(params[:id])
    link.destroy if link
    redirect_to links_url
  end
end
