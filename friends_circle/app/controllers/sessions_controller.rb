class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user])
    if @user
      login_user!
      render :json => @user
    else
      @user = User.new
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    logout_user!
    redirect_to new_session_url
  end
end
