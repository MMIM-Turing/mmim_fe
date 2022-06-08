require 'rails_helper'

RSpec.describe 'results page' do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    data = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_or_create_user).and_return(data)
    visit '/login'
    click_on 'Log in with Google'
    allow(PhotoService).to receive(:get_url).and_return('http//url')
  end


  
  it 'searches by existing user email- happy path', :vcr do 
    within "#user_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :user_b_email, with: "email@email.com"
      click_button 'Search'
    end 

    expect(current_path).to eq('/dashboard/user_results')
  end


  it 'searches by existing user email- sad path', :vcr do 
    within "#user_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :user_b_email, with: "nonexisting@email.com"
      fill_in :category, with: "gym"
      click_button 'Search'
    end 
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Invalid user email. Please try again!')
  end

  it 'searches by existing user email - no default add', :vcr do 
    within "#user_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :user_b_email, with: "no_add@email.com"
      fill_in :category, with: "gym"
      click_button 'Search'
    end 

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('no_add@email.com has not set a default address, please search by address instead!')
  end
end
  