class BadgesController < ApplicationController

  def create
    graph = Koala::Facebook::API.new(get_fb_token)
    fb_user = graph.get_object('me')
    @user = update_fb_user(fb_user)

    new_peak = find_peak(badge_params)
    existing_peak = @user.peaks.find new_peak rescue nil
    unless existing_peak
      @user.peaks << new_peak
      @user.vertical_height = @user.vertical_height ? @user.vertical_height + new_peak.height : new_peak.height
      @user.save
    end
  end

  private
  def badge_params
    params.require(:lat)
    params.require(:lng)
    params.permit(:lat, :lng)
  end

  def find_peak(params)
    peak_geohash = GeoHash.encode(params[:lat].to_f, params[:lng].to_f)
    Peak.find_by geohash: peak_geohash
  end

  def get_fb_token
    request.headers['Fb-Access-Token']
  end

  def update_fb_user(facebook_user)
    user = User.find_or_create_by(fb_id: facebook_user['id'])
    if user.name == ' '
      user.first_name = facebook_user['first_name']
      user.last_name = facebook_user['last_name']
      user.save
    end
    user
  end

end