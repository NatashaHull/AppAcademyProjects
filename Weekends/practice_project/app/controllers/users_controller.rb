class UsersController < ApplicationController
  before_filter :logged_in?, :only => [:index, :show]

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.set_session_token
    if @user.save
      login_user!(@user)
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
end
