class User < ActiveRecord::Base
  has_many :badges
  has_many :peaks, through: :badges

end