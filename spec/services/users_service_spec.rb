require 'rails_helper'

RSpec.describe 'Users service' do
  describe 'class methods' do
    it '#find_or_create_user', :vcr do
      params = { name: 'test user', email: 'test@email.com' }
      user_data = UsersService.find_or_create_user(params)
      expect(user_data).to have_key(:data)
      expect(user_data[:data][:attributes][:name]).to eq('test user')
      expect(user_data[:data][:attributes][:email]).to eq('test@email.com')
      expect(user_data[:data][:attributes][:adress]).to eq(nil)
    end

    it '#create_or_update_address', :vcr do
      params = { name: 'test user', email: 'test@email.com' }
      UsersService.find_or_create_user(params)

      address_params = { email: 'test@email.com', address: '123 st, city, state, 80123' }
      user_updated = UsersService.create_or_update_address(address_params)
      expect(user_updated[:data][:attributes][:name]).to eq('test user')
      expect(user_updated[:data][:attributes][:email]).to eq('test@email.com')
      expect(user_updated[:data][:attributes][:address]).to eq('123 st, city, state, 80123')
    end

    it '#finds a user', :vcr do
      params = { email: 'user_search@email.com' }
      user_data = UsersService.find_user(params)

      expect(user_data).to have_key(:data)
      expect(user_data[:data][:attributes][:name]).to eq('usersearch base')
      expect(user_data[:data][:attributes][:email]).to eq('user_search@email.com')
      expect(user_data[:data][:attributes][:address]).to eq('2001 Colorado Blvd, Denver, CO 80205')
    end

    it '#finds a user sad path', :vcr do
      params = { email: 'nonexisting@test.com' }
      user_data = UsersService.find_user(params)

      expect(user_data).to have_key(:data)
      expect(user_data[:data]).to eq(nil)
    end
  end
end
