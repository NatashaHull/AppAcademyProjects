class CatsController < ApplicationController
  before_filter :logged_in?
  before_filter :logged_in_as_owner?, :only => [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = Cat.new
  end

  def create
    @cat = Cat.new(params[:cat])
    @cat.owner_id = current_user.id
    if @cat.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @cat.update_attributes(params[:cat])
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  private

    def logged_in_as_owner?
      @cat = Cat.find(params[:id])
      unless current_user.id == @cat.owner_id
        redirect_to root_url
      end
    end
end