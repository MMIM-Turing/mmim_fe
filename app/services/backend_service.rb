class BackendService
  class << self
    def get_locations(params)
      response = conn.get("search?params=#{params.to_json}")
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_locations_by_user(params)
      p = params.to_json.gsub('@', '%40')
      response = conn.get("search_by_user?params=#{p}")
      JSON.parse(response.body, symbolize_names: true)
    end

    def create_meetings(params)
      p = params.to_json.gsub('@', '%40')
      p = p.gsub('#', '%23')
      response = conn.post("meeting?params=#{p}")
      JSON.parse(response.body, symbolize_names: true)
    end

    def get_meetings(params)
      p = params.to_json.gsub('@', '%40')
      response = conn.get("user_meetings?params=#{p}")
      JSON.parse(response.body, symbolize_names: true)
    end

    private

    def conn
      if Rails.env.development? || Rails.env.test?
        Faraday.new(ENV['backend_server_dev'])
      else
        Faraday.new(ENV['backend_server_pro'])
      end
    end
  end
end
