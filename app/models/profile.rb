class Profile < ApplicationRecord
  belongs_to :user

  def tweets
  user.tweets
  end

end
