class Peak < ActiveRecord::Base
  has_many :badges
  has_many :users, through: :badges
end
