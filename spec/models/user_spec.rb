require 'spec_helper'

describe User do
  describe 'associations' do
    it { should have_many(:badges)}
    it { should have_many(:peaks).through(:badges) }
  end
end