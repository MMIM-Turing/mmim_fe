require 'rails_helper'

RSpec.describe 'login page' do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    # configured at bottom of rails_helper
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
