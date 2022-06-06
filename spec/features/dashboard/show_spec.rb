require 'rails_helper'

RSpec.describe 'login page' do
  describe 'new default address' do
    before do
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
      data = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
      allow(UsersService).to receive(:find_or_create_user).and_return(data)
      visit '/login'
      click_on 'Log in with Google'
    end
    it 'has a link to login with google and redirects to dashboard' do
      click_on 'Log Out'
      expect(current_path).to eq root_path
      expect(page).to have_content('You have successfully logged out!')
    end

    it 'redirects user to login page if not logged in/logged out' do
      click_on 'Log Out'
      visit dashboard_path

      expect(current_path).to eq('/login')
      expect(page).to have_content('Please log in to proceed!')
    end

    it 'has a link to create default address if non existing' do
      click_on 'Set Default Address'

      expect(current_path).to eq('/dashboard/address')
    end
  end

  describe 'update default address' do
    before do
      Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
      data = JSON.parse(File.read('spec/fixtures/user_add.json'), symbolize_names: true)
      allow(UsersService).to receive(:find_or_create_user).and_return(data)
      visit '/login'
      click_on 'Log in with Google'
    end

    it 'has a link to update default address if existing' do
      expect(page).to have_content('123 St, Denver, CO 80123')

      click_on 'Update Default Address'

      expect(current_path).to eq('/dashboard/address')
    end

    it 'uses a users default address if present', :vcr do

      within "#user_search" do
        page.should have_field(:address_1, with: '123 St, Denver, CO 80123')
      end
    end
  end
end
