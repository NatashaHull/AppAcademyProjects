class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_username_and_password(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      session[:token] = @user.reset_token
      redirect_to links_url
    else
      flash[:errors] = ["Invalid username or password"]
      render :new
    end
  end

  def destroy
    session[:token] = nil
    current_user.reset_token if logged_in?
    redirect_to new_session_url
  end
end
