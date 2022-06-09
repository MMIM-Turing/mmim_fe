class Meeting
  attr_reader :host_name, :guest_name, :location_name, :location_address

  def initialize(data)
    @id = data[:id]
    @host_name = data[:attributes][:host_name]
    @guest_name = data[:attributes][:guest_name]
    @location_name = data[:attributes][:location_name]
    @location_address = data[:attributes][:location_address]
  end
end
