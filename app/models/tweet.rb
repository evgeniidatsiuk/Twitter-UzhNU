class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments,dependent: :destroy
  validates :body, length: { maximum: 50, message: 'Максимум 50 символів' }
  validates :body, presence: { message: 'Майже, введіть ще раз дані' }
end
