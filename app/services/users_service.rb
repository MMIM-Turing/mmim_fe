class UsersService
  def self.find_or_create_user(params)
    response = conn("users?params=#{params.to_json}").post
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.create_or_update_address(params)
    response = conn("users?params=#{params.to_json}").put
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn(uri)
    Faraday.new("http://localhost:3000/api/v1/#{uri}")
  end
end
