class PostsController < ApplicationController
  def index
    render :json => Post.all
  end

  def show
    render :json => Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      render :json => @post
    else
      render :json => @post.errors.full_messages, :status => :unprocessible_entity
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      render :json => @post
    else
      render :json => @post.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    render :json => "Done!"
  end
end
