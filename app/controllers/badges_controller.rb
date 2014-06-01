class BadgesController < ApplicationController

  def create
    graph = Koala::Facebook::API.new(get_fb_token)
    fb_user = graph.get_object('me')
    @user = User.find_or_create_by(fb_id: fb_user['id'])

    new_peak = find_peak(badge_params)
    existing_peak = @user.peaks.find new_peak rescue nil
    unless existing_peak
      @user.peaks << new_peak
    end
  end

  private
  def get_fb_token
    request.headers['Fb-Access-Token']
  end

  def badge_params
    params.require(:lat)
    params.require(:lng)
    params.permit(:lat, :lng)
  end

  def find_peak(params)
    peak_geohash = GeoHash.encode(params[:lat].to_f, params[:lng].to_f)
    Peak.find_by geohash: peak_geohash
  end
end