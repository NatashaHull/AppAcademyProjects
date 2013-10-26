class FriendshipsController < ApplicationController
  before_filter :require_current_user!

  def create
    @friendship = Friendship.new(params[:friendship])
    @friendship.friender_id = current_user.id

    if @friendship.save
      render :json => @friendship
    else
      flash.now[:errors] = @friendship.errors.full_messages
      render :json => { :errors => flash[:errors] }, :status => :unprocessable_entity
    end
  end

  def destroy
    @friendship = Friendship.find_by_friender_id_and_friendee_id(
      current_user.id,
      params[:user_id]
    )

    if !!@friendship
      @friendship.destroy
      render :json => @friendship, :status => :ok
    else
      render :json => { :errors => ["Not a valid friendship!"]}, :status => :unprocessable_entity
    end
  end
end
