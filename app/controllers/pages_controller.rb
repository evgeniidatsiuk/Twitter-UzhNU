class PagesController < ApplicationController
    before_action :authenticate_user!
  def index
    if user_signed_in?
    @tweet = Tweet.new
   @feed = current_user.feed
   @tweets = Tweet.where(id: current_user.id)
 else
   @tweets = Tweets.all
 end
  end
end
