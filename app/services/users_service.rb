class UsersService
  def self.find_or_create_user(params)
    # {
    #   data: {
    #     type: 'user',
    #     id: '1',
    #     attributes: {
    #       name: params[:name],
    #       email: params[:email],
    #       address: params[:address]
    #     }
    #   }
    # }

    response = conn("users?params=#{params.to_json}").post
     JSON.parse(response.body, symbolize_names: true)
  end

  def self.create_or_update_address(params)
        {
      data: {
        type: 'user',
        id: '1',
        attributes: {
          name: params[:name],
          email: params[:email],
          address: params[:address]
        }
      }
    }
  end

  def self.conn(url)
    Faraday.new("http://localhost:3000/api/v1/#{url}")
  end
end
