require 'spec_helper'

describe User do
  describe 'attributes' do
    its(:attributes) { should include 'fb_id'}
    its(:attributes) { should include 'first_name' }
    its(:attributes) { should include 'last_name' }
    its(:attributes) { should include 'vertical_height' }
    its(:attributes) { should include 'created_at' }
    its(:attributes) { should include 'updated_at' }
  end

  describe 'associations' do
    it { should have_many(:badges)}
    it { should have_many(:peaks).through(:badges) }
  end

  #scopes
  describe 'leader_board' do

    it 'should return the largest vertical heights first' do
      low = FactoryGirl.create(:user, vertical_height: 1)
      high = FactoryGirl.create(:user, vertical_height: 100)
      expect( User.leader_board).to eq [high, low]
    end

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

  describe '#name' do

    it 'should return the first name and last name' do
      subject = FactoryGirl.build :user
      expect(subject.name).to eq "#{subject.first_name} #{subject.last_name}"
    end
  end
end