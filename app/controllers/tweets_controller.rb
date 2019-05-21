class TweetsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :find_tweet, only: %i[show edit update destroy]

  def index
  #  @user = User.find_by(id: params[:id])
    @tweet = current_user.tweets.build
    @tweets = Tweet.all
    end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    if @tweet.save

      redirect_back(fallback_location: root_path)
    else
      render 'new'
    end
  end

  def edit; end

  def update
  if  @tweet.update(tweet_params)
  #redirect_back(fallback_location: root_path)
  redirect_to tweet_path(@tweet.id)
else
  render 'edit'
end
    end

  def destroy
  if  @tweet.destroy
  redirect_to tweets_path
end
  end

  def show
 @comment = current_user.comments.build
 @comments=Comment.where(tweet_id: @tweet.id).order(created_at: :desc)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:user_id, :body)
  end

  def find_tweet
   @tweet = Tweet.find(params[:id])
  end
end
