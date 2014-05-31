require 'spec_helper'

describe UserBadge do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:badge) }
  end
end