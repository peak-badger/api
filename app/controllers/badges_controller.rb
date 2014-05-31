class BadgesController < ApplicationController

  def create
    graph = Koala::Facebook::API.new(get_fb_token)
    fb_user = graph.get_object('me')
    @user = User.find_or_create_by(fb_id: fb_user['id'])
    new_badge_id = badge_params
    unless @user.user_badges.where(badge_id: new_badge_id).count == 1
      @user.user_badges.create badge_id: new_badge_id
    end
  end

  private
  def get_fb_token
    request.headers['Fb-Access-Token']
  end

  def badge_params
    params.require(:id)
  end
end