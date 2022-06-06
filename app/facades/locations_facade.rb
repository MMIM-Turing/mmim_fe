class LocationsFacade
  def self.address_location_search(params)

    data = BackendService.get_locations(params)[:data]
    list = data.map do |data|
      Location.new(data[:attributes])
    end
  end

  def self.map_info(locations)
    coordinates = locations.map do |location|
      [location.name, location.latitude, location.longitude]
    end
    average = ['average', coordinates.map{ |c| c[1]}.sum/coordinates.count, coordinates.map{ |c| c[2]}.sum/coordinates.count]
    coordinates.unshift(average)
  end
end
