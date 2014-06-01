require 'spec_helper'

describe Peak do
  describe 'associations' do
    it { should have_many(:badges)}
    it { should have_many(:users).through(:badges)}
  end
end