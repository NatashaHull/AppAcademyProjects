class FeedsController < ApplicationController
  def index
    @feeds = Feed.includes(:entries).all
    
    #Reload if it's been more than two minutes since the last reload.
    most_recent_reload = @feeds.last.updated_at
    current_time = Time.now
    if (current_time - most_recent_reload).to_s > 120
      ActiveRecord::Base.transcation do
        @feeds.each(&:reload)
      end
    end

    respond_to do |format|
      format.html { render :index }
      format.json { render :json => @feeds, :include => :entries }
    end
  end

  def create
    feed = Feed.find_or_create_by_url(params[:feed][:url])
    if feed
      render :json => feed
    else
      render :json => { error: "invalid url" }, status: :unprocessable_entity
    end
  end
end
