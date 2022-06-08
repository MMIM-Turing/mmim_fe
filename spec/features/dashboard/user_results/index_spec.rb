require 'rails_helper'

RSpec.describe 'user results page' do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    data = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_or_create_user).and_return(data)
    visit '/login'
    click_on 'Log in with Google'
    allow(PhotoService).to receive(:get_url).and_return('http//url')
  end



  it 'searches by existing user email- happy path', :vcr do
    data_search = JSON.parse(File.read('spec/fixtures/user_search.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_user).and_return(data_search)

    within "#user_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :user_b_email, with: "user_search@email.com"
      click_button 'Search'
    end

    expect(current_path).to eq('/dashboard/user_results')
  end


  describe 'invalid search', :vcr do
    it 'redirect to dashboard and flash error message when emtpy address input' do

      within "#user_search" do
        fill_in :address_1, with: ''
        fill_in :user_b_email, with: ''
        click_button 'Search'
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Please fill out both address fields')
    end
  end

  it 'searches by existing user email- no midpoints found', :vcr do
    data_search = JSON.parse(File.read('spec/fixtures/user_search.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_user).and_return(data_search)

    within "#user_search" do
      fill_in :address_1, with: "2300 Steele"
      fill_in :user_b_email, with: "user_search@email.com"
      click_button 'Search'
    end

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('No midpoints found-please try different addresses')
  end


  it 'searches by existing user email- sad path', :vcr do
    within "#user_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :user_b_email, with: "nonexisting@email.com"
      select "library", from: :category
      click_button 'Search'
    end
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Invalid user email. Please try again!')
  end

  it 'searches by existing user email - no default add', :vcr do 
    within "#user_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :user_b_email, with: "no_add@email.com"
      select "library", from: :category
      click_button 'Search'
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('no_add@email.com has not set a default address, please search by address instead!')
  end
end
