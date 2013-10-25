class ContactSharesController < ApplicationController
  def create
    @contact_share = ContactShare.new(params[:contact_share])
    if @contact_share.save
      render :json => @contact_share, :status => :created
    else
      render :json => @contact_share.errors, :status => :unprocessable_entity
    end
  end

  def destroy
    @contact_share = ContactShare.find(params[:id])
    if @contact_share.destroy
      render :json => true
    else
      render :json => false
    end
  end
end
