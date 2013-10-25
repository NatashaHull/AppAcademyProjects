class SubsController < ApplicationController

  before_filter :must_be_logged_in, :except => [:index, :show]
  before_filter :must_be_moderator, :only => [:edit, :update, :destroy]

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(params[:sub])
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @sub.update_attributes(params[:sub])
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub.destroy
    redirect_to @sub
  end

  private

  def must_be_moderator
    @sub = Sub.find(params[:id])
    unless @sub.moderator_id == current_user.id
      flash[:errors] = ["You are not the moderator of this sub!"]
      redirect_to @sub
    end
  end
end
