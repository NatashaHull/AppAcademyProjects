class LinksController < ApplicationController
  before_filter :must_be_logged_in, :except => [:index, :show]
  before_filter :must_be_author, :only => [:edit, :update, :destroy]

  def index
    @links = Link.all
    render :index
  end

  def show
    @link = Link.find(params[:id])
    @comments, @children_hash = @link.comments_by_parent_id
    render :show
  end

  def new
    @link = Link.new
    @subs = Sub.all
    render :new
  end

  def create
    @link = Link.new(params[:link])
    @link.author_id = current_user.id
    if @link.save
      redirect_to @link
    else
      flash.now[:errors] = @link.errors.full_messages
      @subs = Sub.all
      render :new
    end
  end

  def edit
    @subs = Sub.all
    render :edit
  end

  def update
    if @link.update_attributes(params[:link])
      redirect_to @link
    else
      flash.now[:errors] = @link.errors.full_messages
      @subs = Sub.all
      render :edit
    end
  end

  def destroy
    @link.destroy
    redirect_to @link
  end

  private

    def must_be_author
      @link = Link.find(params[:id])
      unless @link.author_id == current_user.id
        flash[:errors] = ["This is not your link!"]
        redirect_to @link
      end
    end
end
