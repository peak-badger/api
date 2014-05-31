require 'spec_helper'

describe User do
  describe 'associations' do
    it { should have_many(:user_badges)}
    it { should have_many(:badges).through(:user_badges) }
  end
end