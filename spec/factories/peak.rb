FactoryGirl.define do

  factory :pikes_peak, class: Peak do
    lat     38.8406
    lng     -105.044
    height  14109
    geohash '9wvkcwtqck' # GeoHash.encode(38.8406, -105.044, 10)
  end

  factory :evans_peak, class: Peak do
    lat     39.5886
    lng     -105.643
    height  14264
    geohash '9xhchnch79' # GeoHash.encode(39.5886, -105.643, 10)
  end
end