class User
  attr_reader :name, :email, :address
  def initialize(data)
    @name = data[:name]
    @email = data[:email]
    @address = address_format(data[:address]) if data[:address]
  end

  def street_address
    @address.split(',').first
  end

  def city
    @address.split(',').second.delete(" ")
  end

  def state
    @address.split(',').last.split(' ').first
  end

  def zipcode
    @address.split(',').last.split(' ').last
  end

  def address_format(str)
    state = str.split(',').last.split(' ').first
    add = str.split(/ |\_/).map(&:capitalize).join(" ")
    if state.length == 2
      add.gsub(state.capitalize, state.upcase) 
    else
      add 
    end
  end

end
