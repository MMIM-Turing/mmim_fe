class LocationsFacade
  def self.unregistered_location_search(address_1, address_2, category)
    json = BackendService.parsed_json("search?address_1=#{address_1}&address_2=#{address_2}&category=#{category}")
    data = json[:data][:attributes]
    list = data.map do |location_attributes|
      Location.new(location_attributes)
    end
  end
end
