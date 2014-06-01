require 'spec_helper'

describe BadgesController do

  describe '#create' do

    let(:facebook_id){ 12234 }
    let(:test_peak){ FactoryGirl.create(:pikes_peak) }

    def do_post
      post '/badges', {lat: test_peak.lat, lng: test_peak.lng, format: :json}, { fb_access_token: 1}
      response
    end

    def setup_fb_mocks
      @graph = double()
      Koala::Facebook::API.stub(:new) { @graph }
      @fb_user = {'id' => facebook_id, 'first_name' => 'Test', 'last_name' => 'User'}
      @graph.stub(:get_object) { @fb_user }
    end

    before do
      setup_fb_mocks
    end

    context 'when the FB access token is for a new user' do

      it 'should create a new user' do
        expect{do_post}.to change(User, :count).by(1)
        user = User.last
        expect(user.name).to eq "#{@fb_user['first_name']} #{@fb_user['last_name']}"
      end

      it 'should associate the user to badge' do
        response = do_post
        parsed_response = JSON.parse(response.body)
        user = User.find parsed_response['badge']['user_id']
        expect(user.badges.count).to be 1
      end

      it 'should update the vertical height' do
        response = do_post
        parsed_response = JSON.parse(response.body)
        user = User.find parsed_response['badge']['user_id']
        expect(user.vertical_height).to be_within(1).of(test_peak.height)
      end
    end

    context 'when the FB access token is for an existing user' do

      let(:test_user) { FactoryGirl.create(:user, fb_id: facebook_id)}

      context 'when the badge was already assigned to the user' do

        it 'should not create a new association' do
          FactoryGirl.create(:badge, peak: test_peak, user: test_user)
          do_post
          expect(Badge.where(peak_id: test_peak.id, user_id: test_user.id).count).to be 1
        end
      end

      context 'when the badge was not already assigned to the user' do

        it 'should associate the user to the badge' do
          test_user #create the user
          do_post
          expect(test_user.badges.count).to be 1
        end

        it 'should update the vertical height' do
          test_user
          do_post
          test_user.reload
          expect(test_user.vertical_height).to be_within(1).of(test_peak.height)
        end
      end
    end
  end
end
