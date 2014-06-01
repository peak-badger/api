class User < ActiveRecord::Base
  has_many :badges
  has_many :peaks, through: :badges

  scope :leader_board, -> { order(vertical_height: :desc).limit(10) }

  def name
    "#{first_name} #{last_name}"
  end
end