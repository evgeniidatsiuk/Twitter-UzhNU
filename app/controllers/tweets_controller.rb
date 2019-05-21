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
    @tweet.update(tweet_params)
  redirect_back(fallback_location: root_path)
    end

  def destroy
    @tweet.destroy
  redirect_back(fallback_location: root_path)
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
    @user = User.find_by(id: params[:id])
    @tweet = Tweet.find(params[:id])
  end
end
