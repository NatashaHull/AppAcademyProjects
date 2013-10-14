class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to link_url(@comment.link_id)
    else
      @link = Link.find(@comment.link_id)
      flash[:errors] = @comment.errors.full_messages
      redirect_to @link
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to link_url(@comment.link_id)
  end
end
