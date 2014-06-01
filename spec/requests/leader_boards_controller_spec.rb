require 'spec_helper'

describe LeaderBoardsController do

  describe 'index' do

    it 'should return a list of the top 10 user' do
      FactoryGirl.create_list(:user, 11)
      get 'leader_boards', format: :json
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['users'].size).to be 10
    end

    it 'should return a list sorted by vertical height' do
      10.times do |i|
        FactoryGirl.create(:user, vertical_height: i)
      end
      get 'leader_boards', format: :json
      parsed_response = JSON.parse(response.body)['users']
      previous_height = parsed_response.first['vertical_height']
      parsed_response.each do |user|
        expect(user['vertical_height'] <= previous_height).to be true
        previous_height = user['vertical_height']
      end
    end

    it 'should return the name of the user' do
      test_user = FactoryGirl.create(:user)
      get 'leader_boards', format: :json
      name = JSON.parse(response.body)['users'].first['name']
      expect(name).to eq test_user.name
    end
  end

end
