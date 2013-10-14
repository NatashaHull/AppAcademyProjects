class LinksController < ApplicationController
  before_filter :logged_in?

  def index
    @links = Link.all
  end

  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    @link.user_id = current_user.id
    if @link.save
      redirect_to @link
    else
      flash.now[:errors] = @link.errors.full_messages
      render :new
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      redirect_to @link
    else
      flash.now[:errors] = @link.errors.full_messages
      render :edit
    end
  end

  def destroy
  end
end
