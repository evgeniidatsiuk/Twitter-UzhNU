class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_user, only: %i[show edit update]

  def index
    @profiles = Profile.all
  end


  def new
    if current_user.profile
      redirect_to profile_path(@profile.id)
    else
      @profile = Profile.new
    end
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path(@profile.id)
    else render 'new'
    end
  end

  def show; end

  def edit
    @profile = current_user.profile
  end

  def update
    # @profile = profile.find_by(user_id: current_user.id)
    if @profile.update(profile_params)
      redirect_to profile_path(@profile.id)
    else render 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:user_id, :firstname, :lastname, :age)
  end

  def find_user
    @profile = Profile.find(params[:id])
  end
end
