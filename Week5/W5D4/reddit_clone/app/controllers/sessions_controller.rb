class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user])
    if !!@user
      log_in_user!(@user)
      redirect_to links_url
    else
      @user = User.new
      flash.now[:errors] = ["Invalid email or password"]
      render :new
    end
  end

  def destroy
    log_out_user!(current_user)
  end

end
