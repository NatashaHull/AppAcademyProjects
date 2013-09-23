class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:token] = @user.reset_token
      redirect_to links_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end
end
