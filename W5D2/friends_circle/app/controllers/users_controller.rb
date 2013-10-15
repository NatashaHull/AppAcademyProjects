class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      login_user!
      render :json => @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  # def update
  #   if @user
  #     change_password
  #   else
  #     @user = User.new
  #   end
  # end

  # def change_password
  # end
end
