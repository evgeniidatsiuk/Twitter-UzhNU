class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.build(comment_params)
    redirect_back(fallback_location: root_path) if comment.save
  end

  def destroy
    comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :text,:tweet_id)
  end

  def comment
    @comment ||= current_user.comments.find_by(id: params[:id])
    @comment ||= Comment.new
  end
end
