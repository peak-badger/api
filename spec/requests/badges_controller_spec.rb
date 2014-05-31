require 'spec_helper'

describe BadgesController do

  describe '#create' do

    let(:facebook_id){ 12234 }
    let(:test_badge){ FactoryGirl.create(:badge) }

    def do_post
      post '/badges', {id: test_badge.id, format: :json}, { fb_access_token: 1}
      response
    end

    def setup_fb_mocks
      @graph = double()
      Koala::Facebook::API.stub(:new) { @graph }
      fb_user = {'id' => facebook_id}
      @graph.stub(:get_object) { fb_user }
    end

    before do
      setup_fb_mocks
    end

    it 'should check the FB access token' do
      Koala::Facebook::API.should_receive(:new) { @graph }
      do_post
    end

    context 'when the FB access token is for a new user' do

      it 'should create a new user' do
        expect{do_post}.to change(User, :count).by(1)
      end

      it 'should associate the user to badge' do
        response = do_post
        parsed_response = JSON.parse(response.body)
        user = User.find parsed_response['user']['id']
        expect(user.badges.count).to be 1
      end
    end

    context 'when the FB access token is for an existing user' do

      let(:test_user) { FactoryGirl.create(:user, fb_id: facebook_id)}

      context 'when the badge was already assigned to the user' do

        it 'should not create a new association' do
          FactoryGirl.create(:user_badge, badge: test_badge, user: test_user)
          do_post
          expect(UserBadge.where(badge_id: test_badge.id, user_id: test_user.id).count).to be 1
        end
      end

      context 'when the badge was not already assigned to the user' do

        it 'should associate the user to the badge' do
          test_user #create the user
          do_post
          expect(test_user.badges.count).to be 1
        end
      end
    end
  end
end