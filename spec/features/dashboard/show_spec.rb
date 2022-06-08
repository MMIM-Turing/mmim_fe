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

  describe 'suggest a meeting' do
    it 'has a form to create a meeting', :vcr do
      data = JSON.parse(File.read('spec/fixtures/user_b.json'), symbolize_names: true)
      allow(UsersService).to receive(:find_or_create_user).and_return(data)
      allow(PhotoService).to receive(:get_url).and_return('http//url')
      
      visit '/login'

      click_on 'Log in with Google'
      click_on 'Log Out'

      data = JSON.parse(File.read('spec/fixtures/user_a.json'), symbolize_names: true)
      allow(UsersService).to receive(:find_or_create_user).and_return(data)
      click_on 'Login'
      click_on 'Log in with Google'

      within "#user_search" do
        data = JSON.parse(File.read('spec/fixtures/washington.json'), symbolize_names: true)
        allow(BackendService).to receive(:get_locations_by_user).and_return(data)

        fill_in :user_b_email, with: 'test@test.com'
        click_button 'Search'
      end

      find("input[type='checkbox'][value='ChIJFaK2ddS3t4kR4LLXUHpoLC0']").set(true)
      find("input[type='checkbox'][value='ChIJZ1xnLNq3t4kRMWSzJo7OC6k']").set(true)
      find("input[type='checkbox'][value='ChIJu9YSTc-3t4kRWcD2pLsGRSI']").set(true)

      loc_1 = Location.new({ name: "Open City", address: "2331 Calvert Street Northwest, Washington" })
      loc_2 = Location.new({ name: "Tryst", address: "2459 18th Street Northwest, Washington" })
      loc_3 = Location.new({ name: "Teaism Dupont Circle", address: "2009 R Street Northwest, Washington" })

      locations = [loc_1, loc_2, loc_3]

      data = SuggestedMeeting.new({guest_email: "sample@sample.com", host_email: "test@test.com", locations: locations})

      allow_any_instance_of(DashboardController).to receive(:suggested_meetings).and_return([data])

      allow_any_instance_of(DashboardController).to receive(:suggested_locations).and_return(locations)

      click_on 'Request a meeting'

      expect(current_path).to eq('/dashboard')

      expect(page).to have_content('Open City')
      expect(page).to have_content('Tryst')
      expect(page).to have_content('Teaism Dupont Circle')
      expect(page).to have_no_content('Starbucks')
      expect(page).to have_no_content("Dawson's Market")
    end
  end
end
