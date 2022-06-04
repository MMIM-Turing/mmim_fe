class User
  attr_reader :name, :email, :address

  def initialize(data)
    @name = data[:name]
    @email = data[:email]
    @address = data[:address]
  end
end
