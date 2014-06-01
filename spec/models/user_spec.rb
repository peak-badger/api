require 'spec_helper'

describe User do
  describe 'associations' do
    it { should have_many(:badges)}
    it { should have_many(:peaks).through(:badges) }
  end

  describe 'leader_board' do

    context 'when there are less than 10 users' do

      it 'should return all users' do
        FactoryGirl.create_list(:user, 7)
        expect( User.leader_board.count).to be 7
      end
    end

    context 'when there are ten or more users' do

      it 'should return only ten users' do
        FactoryGirl.create_list(:user, 11)
        expect( User.leader_board.count).to be 10
      end
    end
  end
end