class SessionsController < ApplicationController
  before_filter :logged_in?, :only => [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
      )
    if !!@user
      login_user!(@user)
      redirect_to links_url
    else
      @user = User.new
      flash.now[:errors] = ["Incorrect username or password!"]
      render :new
    end
  end

  def destroy
    @user = current_user
    logout_user!(@user)
    redirect_to new_session_url
  end
end
