class BackendService
  def self.conn
    if Rails.env == 'development' || Rails.env == 'test'
      Faraday.new(ENV["backend_server_dev"])
    else
      Faraday.new(ENV["backend_server_pro"])
    end

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
  def self.create_meetings(params)
    p = params.to_json.gsub("@", "%40")
    p = p.gsub("#", '%23')
    response = conn.post("meeting?params=#{p}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_meetings(params)
    p = params.to_json.gsub("@", "%40")
    response = conn.get("user_meetings?params=#{p}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
