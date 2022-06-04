class BackendService
  def self.conn
     Faraday.new('http://localhost:3000/api/v1')
  end

  def self.post_request(uri)
    response = conn.post(uri)
    JSON.parse(response.body, symbolize_names: true)
  end
end
