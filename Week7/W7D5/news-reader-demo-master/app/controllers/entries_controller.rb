class EntriesController < ApplicationController
  def index
    feed = Feed.find(params[:feed_id])
    render :json => feed.entries
  end
end
