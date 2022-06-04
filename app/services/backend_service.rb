class BackendService
  def self.conn
     Faraday.new('http://localhost:3000/api/v1')
  end

  def self.get_locations(params)
    # switch to these when we connect to backend
    # response = conn.get("search?params=#{params}")
    # JSON.parse(response.body, symbolize_names: true)
    response = File.read('spec/fixtures/locations.json')
    JSON.parse(response, symbolize_names: true)
  end
end
