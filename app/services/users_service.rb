class UsersService
  class << self
    def find_or_create_user(params)
      response = conn("users?params=#{params.to_json}").post
      JSON.parse(response.body, symbolize_names: true)
    end

    def find_user(params)
      response = conn("find_user?params=#{params.to_json}").get
      JSON.parse(response.body, symbolize_names:true)
    end

    def create_or_update_address(params)
      response = conn("users?params=#{params.to_json}").put
      JSON.parse(response.body, symbolize_names: true)
    end

private 
    def conn(uri)
      Faraday.new("#{ENV['backend_server']}/#{uri}")
    end
  end
end
