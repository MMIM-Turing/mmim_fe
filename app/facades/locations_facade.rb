class LocationsFacade
  def self.address_location_search(params)
    data = BackendService.get_locations(params)[:data]
    list = data.map do |data|
      Location.new(data[:attributes])
    end
  end
end
