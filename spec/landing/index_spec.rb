require 'rails_helper'

RSpec.describe 'landing page' do
  describe 'form' do
    it 'contains two address input areas' do
      visit '/'

      expect(page).to have_field(:address_1)
      expect(page).to have_field(:address_2)
    end

    it 'has a category field' do
      visit '/'

      expect(page).to have_field(:category)
    end

    it 'sends user to results page' do
      visit '/'
      click_button 'Search'

      expect(current_path).to eq('/results')
    end
  end
end
