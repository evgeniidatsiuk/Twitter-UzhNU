class UsersController < ApplicationController
  before_action :find_user, only: %i[show followers following]
    def show

    end

    def index
      @users = User.all
    end

    def following
       @users = @user.following
       render 'relationships/follows'
     end

     def followers
        @users = @user.followers
       render 'relationships/follows'
   end
   private

    def find_user
    @user = User.find(params[:id])
    end

end
