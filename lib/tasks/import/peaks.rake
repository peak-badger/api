namespace :import do
  desc 'import peak data from json file'
  task peaks: :environment do
    peaks = JSON.parse(File.read 'lib/tasks/import/peaks.json')
    peaks.each do |peak|
      properties = peak['properties']
      if properties && properties['latitude'] && properties['longitude']
        Peak.create name: properties['name'],
            lat: properties['latitude'],
            lng: properties['longitude'],
            height: properties['feet'],
            geohash: GeoHash.encode(properties['latitude'].to_f, properties['longitude'].to_f, 10)
      end
    end
  end

end
