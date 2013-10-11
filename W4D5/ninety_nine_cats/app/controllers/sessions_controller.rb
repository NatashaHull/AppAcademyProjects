class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],
                                     params[:user][:password])
    if !!@user
      login_user!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = ["Invalid username or password (or both)"]
      @user = User.new
      render :new
    end
  end

  def destroy
    @user = current_user
    logout_user!(@user) if !!@user
    redirect_to new_session_url
  end

  def see_request_possibilities
    render :json => request.env["HTTP_USER_AGENT"]
  end
end
