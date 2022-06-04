class LocationsFacade
  def self.unregistered_location_search(address_1, address_2, category)
    json = BackendService.post_request("search?address_1=#{address_1}&address_2=#{address_2}&category=#{category}")
    data = json[:data]
    list = data.map do |location_data|
      Location.new(location_data)
    end
  end
end
