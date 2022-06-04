require 'rails_helper'

RSpec.describe 'backend service' do
  describe 'class methods' do
    xit '#conn' do



    end

    it '#get_locations' do
      expect(BackendService.get_locations('spec/fixtures/locations.json')).to have_key(:data)
    end
  end
end
