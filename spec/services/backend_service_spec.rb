require 'rails_helper'

RSpec.describe 'backend service' do
  describe 'class methods' do
    xit '#conn' do



    end

    it '#get_locations', :vcr do
      params = {address_1: '3643 W Colfax Ave, Denver, CO 80204',address_2: '2300 Steele St Denver CO 80205', category: 'cafe'}
      expect(BackendService.get_locations(params)).to have_key(:data)
    end
  end
end
