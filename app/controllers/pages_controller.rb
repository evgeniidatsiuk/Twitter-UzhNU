class PagesController < ApplicationController
    before_action :authenticate_user!
  def index
    @profile = Profile.find_by(user_id: current_user.id)

    @tweet = current_user.tweets.build
    @tweets = Tweet.all
  end
end
