class User < ActiveRecord::Base
  has_many :badges
  has_many :peaks, through: :badges

  scope :leader_board, -> { order(:vertical_height).limit(10) }

end