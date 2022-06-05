require 'rails_helper'

RSpec.describe 'locations facade' do
  describe 'class methods' do
    it '#address_location_search' do
      params = {address_1: '123 Easy Street, Denver CO',address_2: '456 Peasy Street, Denver CO', category: 'coffee shop'}

      expect(LocationsFacade.address_location_search(params)).to be_a(Array)
      expect(LocationsFacade.address_location_search(params).count).to eq(5)
      
      LocationsFacade.address_location_search(params).each do |location|
        expect(location).to be_a(Location)
      end
    end
  end
end
