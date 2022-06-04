class UsersService

  def self.find_or_create_user(params)
  	response = conn('users').post('post') do |req|
  	  #req.headers['mmim_api_key'] = 'tbd'
  	  req.body = params.to_json
  	end
    JSON.parse(response.body, symbolize_names: true) 
  end

  def self.conn(url)
    Faraday.new("http://localhost:3000/api/v1/#{url}")
  end
end