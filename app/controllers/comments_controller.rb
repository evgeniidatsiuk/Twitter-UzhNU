class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_image, only: %i[update destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to image_path(@image.id)
    end
  end

  def update
  end

  def destroy
  end

  def index
#  @comments = @comments.tweet #@comments = Image.where(id: @comment.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :image_id, :text)
  end

  def find_image
   @image = Image.find_by(id: params[:image_id])
  end
end
