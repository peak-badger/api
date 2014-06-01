FactoryGirl.define do

  factory :pikes_peak, class: Peak do
    lat     38.8406
    lng     -105.044
    height  14109
    geohash '9wvkcwtqck' # GeoHash.encode(38.8406, -105.044, 10)
  end
end