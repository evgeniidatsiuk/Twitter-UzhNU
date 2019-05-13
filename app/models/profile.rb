class Profile < ApplicationRecord
  belongs_to :user

  def tweets
  user.tweets
  end
  
  def followers
  user.followers
  end


end
