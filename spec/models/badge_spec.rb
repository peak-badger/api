require 'spec_helper'

describe Badge do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:peak) }
  end
end