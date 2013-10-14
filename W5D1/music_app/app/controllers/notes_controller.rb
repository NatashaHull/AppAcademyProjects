class NotesController < ApplicationController
  before_filter :logged_in?
  before_filter :owned_by_current_user?, :only => [:destroy]

  def create
    @note = Note.new(
      :track_id => params[:track_id],
      :body => params[:body]
      )
    @note.user_id = current_user.id
    if @note.save
      redirect_to track_url(@note.track_id)
    else
      @track = Track.find(params[:track_id])
      flash.now[:errors] = @note.errors.full_messages
      render 'tracks/show'
    end
  end

  def destroy
    @note.destroy
    redirect_to track_url(@note.track_id)
  end

  private
    def owned_by_current_user?
      @note = Note.find(params[:id])
      unless !!current_user && current_user.id == note.user_id
        flash[:errors] = ["You can't delete other people's notes!"]
        redirect_to track_url(@note.track_id)
      end
    end
end
