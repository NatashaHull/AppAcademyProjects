class SecretsController < ApplicationController
  before_filter :require_current_user!

  def new
    @secret = Secret.new(:recipient_id => params[:user_id])
  end

  def create
    @secret = Secret.new(params[:secret])
    @secret.author_id = current_user.id

    if @secret.save
      render :json => @secret
    else
      flash.now[:errors] = @secret.errors.full_messages
      render :json => { :errors => flash[:errors] }, :status => :unprocessable_entity
    end
  end
end
