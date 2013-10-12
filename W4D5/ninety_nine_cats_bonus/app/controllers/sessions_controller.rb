class SessionsController < ApplicationController
  before_filter :session_belongs_to_user, :only => [:logout_session]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],
                                     params[:user][:password])
    if !!@user
      login_user!(@user)
      redirect_to @user
    else
      flash.now[:errors] = ["Invalid username or password (or both)"]
      @user = User.new
      render :new
    end
  end

  #Destroys all sessions for a user
  def destroy
    @user = current_user
    logout_user!(@user) if !!@user
    redirect_to new_session_url
  end

  #Destroys one session for a user
  def logout_session
    logout_session!(@session_token)
    redirect_to user_url(current_user)
  end

  private

  def session_belongs_to_user
    @session_token = SessionToken.find(params[:session_id])
      unless @session_token.user_id == current_user.id
        flash[:errors] = ["This is not your session to delete!"]
        redirect_to user_url(current_user)
      end
    end
end
