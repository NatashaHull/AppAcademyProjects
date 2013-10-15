class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
      )
    if !!@user
      login_user!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Incorrect email or password!"]
      render :new
    end
  end

  def destroy
    logout_user!(current_user)
    redirect_to new_session_url
  end
end
