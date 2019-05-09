class PagesController < ApplicationController
    before_action :authenticate_user!
  def index
    @tweet = current_user.tweets.build
    @tweets = Tweet.all
  end
end
