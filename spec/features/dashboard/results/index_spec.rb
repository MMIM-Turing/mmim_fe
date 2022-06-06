require 'rails_helper'

RSpec.describe 'results page' do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'displays category' do
    data = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_or_create_user).and_return(data)

    visit '/login'

    click_on 'Log in with Google'

    fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
    fill_in :address_2, with: "1155 W 5th Ave, Denver, CO 80204"
    fill_in :category, with: "gym"
    click_button 'Search'

    expect(page).to have_content("Gym")
    expect(page).to have_no_content("Cafe")
  end

  xit 'uses a users default address if present' do

  end

  it 'has a form to update category' do
    data = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_or_create_user).and_return(data)

    visit '/login'

    click_on 'Log in with Google'

    fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
    fill_in :address_2, with: "1155 W 5th Ave, Denver, CO 80204"
    fill_in :category, with: "gym"

    click_button 'Search'

    fill_in :category, with: "bar"
    click_button 'Update Category'

    expect(current_path).to eq('/dashboard/results')
    expect(page).to have_content("Bar")
    expect(page).to have_no_content("Gym")  
  end
end
