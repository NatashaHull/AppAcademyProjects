class SessionsController < ApplicationController
  def new
    @user = User.new
    render "new", :layout => "sans_signin"
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],
                                    params[:user][:password])

    if @user
      login_user(@user)
      redirect_to @user
    else
      @user = User.new
      flash.now[:errors] = ["Invalid email/password."]
      render "new", :layout => "sans_signin"
    end
  end

  def destroy
    return if session[:token].nil?

    logout_user(current_user)
    redirect_to new_session_url
  end
end
