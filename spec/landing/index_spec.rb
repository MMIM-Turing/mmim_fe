require 'rails_helper'

RSpec.describe 'landing page' do
  describe 'form' do
    it 'contains two address input areas' do
      visit '/'

      expect(page).to have_field(:address_1)
      expect(page).to have_field(:address_2)
    end
  end
end
