class BackendService
  def self.conn
    Faraday.new('http://localhost:3000/api/v1')
  end

  def self.get_locations(params)
    response = conn.get("search?params=#{params.to_json}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
