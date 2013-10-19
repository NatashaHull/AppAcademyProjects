class GoalsController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  before_filter :require_goal_owner, :only => [:edit, :update, :destroy]
  before_filter :require_private_goal_owner, :only => [:show]

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(params[:goal])
    @goal.user_id = current_user.id

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @goal.update_attributes(params[:goal])
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def index
    @goals = Goal.where(:private_goal => false)
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  private

  def require_goal_owner
    @goal = Goal.find(params[:id])
    redirect_to @goal unless @goal.user_id == current_user.id
  end

  def require_private_goal_owner
    @goal = Goal.find(params[:id])
    if @goal.private_goal && (!current_user ||
       @goal.user_id != current_user.id)
       redirect_to goals_url
     end
   end

end
