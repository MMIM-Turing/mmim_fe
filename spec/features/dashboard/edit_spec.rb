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

  it 'has a form to create default address if non existing' do 
    data = JSON.parse(File.read('spec/fixtures/user_add.json'), symbolize_names: true)
    allow(UsersService).to receive(:create_or_update_address).and_return(data)
    user_data = {:name=>"someone", :email=>"sample@email.com", :address=>"123 st, Denver, CO 80123"}
    user = User.new(user_data) 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    click_on 'Set Default Address'
    fill_in :street, with: '123 st'
    fill_in :city, with: 'Denver'
    fill_in :state, with: 'Colorado'
    fill_in :zipcode, with: '80123'
    click_on 'Set Default Address'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('My Default Address:')
    expect(page).to have_content('123 St, Denver, CO 80123')
    expect(page).to_not have_link('Set Default Address')
    expect(page).to have_link('Update Default Address')
  end
end
