require 'rails_helper'

RSpec.describe 'landing page' do
  describe 'navbar' do
<<<<<<< HEAD
   it 'has a link to login and redirects to a login page' do
  	visit root_path

=======

    it 'has a link to login and redirects to a login page' do
      visit root_path
>>>>>>> 541081dee749c463fc046dd19b031e72519a7b13
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

    it 'sends user to results page' do
      visit '/'
      fill_in :address_1, with: "123 Easy Street, Denver CO"
      fill_in :address_2, with: "456 Peasy Street, Denver CO"
      click_button 'Search'

      expect(current_path).to eq('/results')
    end
  end

  describe 'sad path empty address fields' do
    it 'redirects user to landing page with flash message' do
      visit '/'

      click_button 'Search'
      expect(current_path).to eq('/')
      expect(page).to have_content("Please fill out both address fields")
    end
  end
end
