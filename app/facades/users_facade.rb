class UsersFacade
  def self.find_or_create_user(params)
    user_data = UsersService.find_or_create_user(params)[:data][:attributes]
    User.new(user_data)
  end
end
