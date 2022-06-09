class UsersFacade
  def self.find_or_create_user(params)
    user_data = UsersService.find_or_create_user(params)[:data][:attributes]
    User.new(user_data)
  end

  def self.create_or_update_address(params)
    user_data = UsersService.create_or_update_address(params)[:data][:attributes]
    User.new(user_data)
  end

  def self.find_user(params)
    data = UsersService.find_user(params)
    if data[:data].nil?
      'invalid email'
    else
      User.new(data[:data][:attributes])
    end
  end
end
