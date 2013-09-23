class CommentsController < ApplicationController  
  def create
    # the comment form only posts :comment => { :body=> "betta axe somboday" }
    # it does not post a link id, so to relate this comment 
    # to a link we add it to the params hash manually lik this
    params[:comment][:link_id] = params[:link_id]
    
    @comment = Comment.new(params[:comment])
    if @comment.save
      redirect_to link_url(@comment.link)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to link_url(params[:link_id])
    end
  end

  def destroy
    comment = Comment.find_by_id(params[:id])
    link = comment.link # save for later redirection
    comment.destroy
    redirect_to link_url(link)
  end
end
