class UsersController < ApplicationController
  before_filter :logged_in?, :only => [:index, :show]
  before_filter :admin?, :only => [:index]

  def index
    @users = User.all
  end

  def show
    if current_user.activated
      redirect_to root_url
    elsif
      msg = UserMailer.register(current_user)
      msg.deliver!
      render :text => "Welcome #{current_user.email}, you should
                      receive an email to activate your account
                      shortly!"
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.set_activation_token
    if @user.save
      login_user!(@user)
      redirect_to @user
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def activate
    @user = User.find_by_activation_token(params[:activation_token])
    if @user
      @user.activate!
      redirect_to new_session_url
    else
      redirect_to new_user_url
    end
  end

  def admin
    @user = User.find(params[:user_id])
    @user.make_admin!
    redirect_to users_url
  end
end
