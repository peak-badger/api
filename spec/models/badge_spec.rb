require 'spec_helper'

describe Badge do
  describe 'associations' do
    it { should have_many(:user_badges)}
    it { should have_many(:users).through(:user_badges)}
  end
end