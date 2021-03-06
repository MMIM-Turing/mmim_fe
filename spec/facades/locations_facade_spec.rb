require 'rails_helper'

RSpec.describe 'locations facade' do
  describe 'class methods' do
    it '#address_location_search', :vcr do
      params = { address_1: '3643 W Colfax Ave, Denver, CO 80204', address_2: '2300 Steele St Denver CO 80205',
                 category: 'cafe' }

      expect(LocationsFacade.address_location_search(params)).to be_a(Array)
      expect(LocationsFacade.address_location_search(params).count).to eq(5)

      LocationsFacade.address_location_search(params).each do |location|
        expect(location).to be_a(Location)
      end
    end

    it '#user_search', :vcr do
      user_b = UsersService.find_or_create_user({ name: 'Test User', email: 'test@test.com',
                                                  address: '1600 Pennsylvania Ave, Washington' })
      params = { address_1: '23 U St NW, Washington, DC 20001', user_b_email: 'test@test.com', category: 'cafe' }

      expect(LocationsFacade.user_search(params)).to be_a(Array)

      LocationsFacade.user_search(params).each do |location|
        expect(location).to be_a(Location)
      end
    end
  end
end
