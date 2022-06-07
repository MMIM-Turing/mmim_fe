require 'rails_helper'

RSpec.describe 'results page' do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
  end

  it 'displays category', :vcr do
    data = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_or_create_user).and_return(data)

    visit '/login'

    click_on 'Log in with Google'

    within "#address_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :address_2, with: "1155 W 5th Ave, Denver, CO 80204"
      fill_in :category, with: "gym"
      click_button 'Search'
    end

    expect(page).to have_content("Gym")
    expect(page).to have_no_content("Cafe")
  end

  it 'has a form to update category', :vcr do
    data = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_or_create_user).and_return(data)

    visit '/login'

    click_on 'Log in with Google'

    within "#address_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :address_2, with: "1155 W 5th Ave, Denver, CO 80204"
      fill_in :category, with: "gym"
      click_button 'Search'
    end

    fill_in :category, with: "bar"
    click_button 'Update Category'

    expect(current_path).to eq('/dashboard/results')
    expect(page).to have_content("Bar")
    expect(page).to have_no_content("Gym")
  end

  it 'has a map', :vcr do
    data = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_or_create_user).and_return(data)

    visit '/login'

    click_on 'Log in with Google'

    within "#address_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :address_2, with: "1155 W 5th Ave, Denver, CO 80204"
      fill_in :category, with: "gym"
      click_button 'Search'
    end

    expect(page).to have_css('#map')
  end

  it 'has a list of locations', :vcr do
    data = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_or_create_user).and_return(data)

    visit '/login'

    click_on 'Log in with Google'

    within "#address_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :address_2, with: "1155 W 5th Ave, Denver, CO 80204"
      fill_in :category, with: "gym"
      click_button 'Search'
    end

    expect(page).to have_css('#locations')
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

    click_on 'Request a meeting'

    expect(current_path).to eq('/dashboard')

    expect(page).to have_content('Open City')
    expect(page).to have_content('Tryst')
    expect(page).to have_content('Teaism Dupont Circle')
    expect(page).to have_no_content('Starbucks')
    expect(page).to have_no_content("Dawson's Market")
  end
end
