require 'rails_helper'

RSpec.describe 'results page' do
  params = { address_1: '3643 W Colfax Ave, Denver, CO 80204', address_2: '2300 Steele St Denver CO 80205',
             category: 'cafe' }

  before :each do
    visit '/'
    fill_in :address_1, with: '3643 W Colfax Ave, Denver, CO 80204'
    fill_in :address_2, with: '2300 Steele St Denver CO 80205'
    allow(PhotoService).to receive(:get_url).and_return('http//url')

  end

  describe 'map card' do
    xit 'displays a map' do
      click_button 'Search'

      expect(page).to have_xpath('//a')
    end
  end

  describe 'invalid search' do
    it 'redirect to dashboard and flash error message when emtpy address input' do
      visit '/'
      fill_in :address_1, with: ''
      fill_in :address_2, with: ''
      click_button 'Search'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Please fill out both address fields')

    end
  end

  describe 'no results search' do
    it 'redirect to dashboard and flash alert message when no results found', :vcr do
      visit '/'
      fill_in :address_1, with: '123 st'
      fill_in :address_2, with: '249 st'
      click_button 'Search'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('No midpoints found-please try different addresses')
    end
  end


  describe 'result list card' do
    context 'category' do
      it 'displays category', :vcr do
        fill_in :category, with: 'park'
        click_button 'Search'

        expect(page).to have_content('Park')
        expect(page).to have_no_content('Coffee shop')
      end

      it 'displays coffee shop as the default category', :vcr do
        click_button 'Search'

        # NOTE: that we didn't fill out :category in the before block
        expect(page).to have_content('Cafe')
      end

      it 'has a form to update category', :vcr do
        click_button 'Search'
        fill_in :category, with: 'bar'
        click_button 'Update Category'

        expect(current_path).to eq('/results')
        expect(page).to have_content('Bar')
        expect(page).to have_no_content('Coffee shop')
      end

      it 'has a form to create a meeting', :vcr do
        data = JSON.parse(File.read('spec/fixtures/user_b.json'), symbolize_names: true)
        allow(UsersService).to receive(:find_or_create_user).and_return(data)

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
end
