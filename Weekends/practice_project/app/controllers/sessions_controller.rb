class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],
                                     params[:user][:password])
    if @user
      login_user!(@user)
      redirect_to @user
    else
      flash.now[:errors] = ["Incorrect username or password (or both)"]
      @user = User.new(:username => params[:user][:username])
      render :new
    end
  end

  def destroy
    logout_user!(current_user)
    redirect_to new_session_url
  end
end
