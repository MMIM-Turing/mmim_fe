require 'rails_helper'

RSpec.describe 'landing page' do
  describe 'navbar' do
    it 'has a link to login and redirects to a login page' do
      visit root_path

      click_on 'Login'

      expect(current_path).to eq('/login')
    end
  end

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

    it 'sends user to results page', :vcr do
      visit '/'
      allow(PhotoService).to receive(:get_url).and_return('http//url')

      fill_in :address_1, with: '2300 Steele St Denver CO 80205'
      fill_in :address_2, with: '3643 W Colfax Ave, Denver, CO 80204'
      select 'cafe', from: :category

      click_button 'Find a middle place'

      expect(current_path).to eq('/results')
    end
  end

  describe 'sad path empty address fields' do
    it 'redirects user to landing page with flash message' do
      visit '/'

      click_button 'Find a middle place'
      expect(current_path).to eq('/')
      expect(page).to have_content('Please fill out both address fields')
    end
  end
end
