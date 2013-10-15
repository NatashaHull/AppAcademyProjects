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

  def reset_password_email
  end

  def reset_password_submit
    @user = User.find_by_email(params[:email])
    if @user
      m = UsersMailer.reset_email(@user)
      m.deliver!
      render :json => "You should receive an email to reset your
                       password shortly"
    else
      flash.now[:errors] = ["This user does not exist"]
      render :reset_password_email
    end
  end

  def reset_password
    @user = User.find_by_reset_token(params[:reset_token])
    if !!@user
      session[:reset_token] = @user.reset_token
      render :reset_password
    else
      render :reset_password_email
    end
  end

  def update
    @user = User.find_by_reset_token(session[:reset_token])
    if @user
      change_password
    else
      render :reset_password_email
    end
  end

  def change_password
    @user.reset_reset_token!
    session[:reset_token] = nil
    @user.password = params[:password]
    if @user.save
      render :json => @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :reset_password
    end
  end
end
