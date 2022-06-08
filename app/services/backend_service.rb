class BackendService
  def self.conn
    Faraday.new(ENV['backend_server'])
  end

  def self.get_locations(params)
    response = conn.get("search?params=#{params.to_json}")
    JSON.parse(response.body, symbolize_names: true)
  end


  def self.get_locations_by_user(params)
    p = params.to_json.gsub("@", "%40")
    response = conn.get("search_by_user?params=#{p}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
