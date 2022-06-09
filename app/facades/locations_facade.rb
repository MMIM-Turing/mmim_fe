class LocationsFacade
  def self.address_location_search(params)
    data = BackendService.get_locations(params)
    if data[:status] == 500
      []
    else
      list = data[:data].map do |data|
        Location.new(data[:attributes])
      end
    end
  end

  def self.user_search(params)
    data = BackendService.get_locations_by_user(params)
    if data[:status] == 500
      []
    else
      list = data[:data].map do |data|
        Location.new(data[:attributes])
      end
    end
  end

  def self.map_info(locations)
    coordinates = locations.map do |location|
      [location.name, location.latitude, location.longitude]
    end
    if coordinates != []
      average = ['average', coordinates.map { |c| c[1] }.sum / coordinates.count, coordinates.map do |c|
                                                                                    c[2]
                                                                                  end.sum / coordinates.count]
      coordinates.unshift(average)
    else
      'No results found'
    end
  end
end
