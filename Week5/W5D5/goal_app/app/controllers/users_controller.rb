class UsersController < ApplicationController
  def new
    @user = User.new
    render "new", :layout => "sans_signup"
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      login_user(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render "new", :layout => "sans_signup"
    end
  end

  def show
    @user = User.find(params[:id])
    goals = @user.goals
    @private_goals = goals.select(&:private_goal)
    @public_goals = goals.reject(&:private_goal)
  end
end
