class TweetsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :find_tweet, only: %i[show edit update]

  def index
    @tweets = Tweet.all
    end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    if @tweet.save

      redirect_to tweet_path(@tweet.id)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    @tweet.update(tweet_params)
    redirect_to tweet_path(@tweet.id)
    end

  def destroy
    @tweet.destroy
    redirect_to tweets_path
  end

  def show; end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :body)
  end

  def find_tweet
    @tweet = Tweet.find(params[:id])
  end
end
