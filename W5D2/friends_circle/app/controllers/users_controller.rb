class UsersController < ApplicationController
  before_filter :must_be_logged_in, :only => [:index, :show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @circles = (@user.circles + @user.circle_memberships)
  end

  def create
    @user = User.new(params[:user])
    @user.set_reset_token
    if @user.save
      login_user!
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  #All of the following actions are for password resets
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

  private

    def change_password
      @user.reset_reset_token!
      session[:reset_token] = nil
      @user.password = params[:password]
      if @user.save
        redirect_to @user
      else
        flash.now[:errors] = @user.errors.full_messages
        render :reset_password
      end
    end
end
