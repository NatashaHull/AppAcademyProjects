class UsersController < ApplicationController
  before_filter :logged_in?, :only => [:edit, :update]

  def show
    @cats = current_user.cats
    @sessions = current_user.session_tokens
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.reset_session_token!
    if @user.save!
      login_user!(@user)
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.is_password?(params[:user][:password])
      @user.password = params[:user][:new_password]
      if @user.save
        redirect_to user_url(@user)
      else
        flash.now[:errors] = @user.errors.full_messages
        render :edit
      end
    else
      flash.now[:errors] = "This is not your password!"
      render :edit
    end
  end
end
