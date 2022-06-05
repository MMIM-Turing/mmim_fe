class LocationsFacade
  def self.address_location_search(params)
    data = BackendService.get_locations(params)[:data]
    list = data.map do |data|
      Location.new(data[:attributes])
    end
  end

  def self.map_info(locations)
    locations.map do |location|
      [location.name, location.longitude, location.latitude]
    end
  end
end
