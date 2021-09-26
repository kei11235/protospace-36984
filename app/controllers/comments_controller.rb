class CommentsController < ApplicationController

  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = @prototype.comments.new(comment_params)
    @comments = @prototype.comments.includes(:user)
    if @comment.save
      redirect_to prototype_path(@prototype.id)
    else
      render "prototypes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(prototype_id: params[:id], user_id: current_user.id)
  end

end
