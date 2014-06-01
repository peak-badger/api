class Badge < ActiveRecord::Base
  belongs_to :user
  belongs_to :peak
end
