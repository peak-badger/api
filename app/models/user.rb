class User < ActiveRecord::Base
  has_many :user_badges
  has_many :badges, through: :user_badges

end