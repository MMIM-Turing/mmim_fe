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

  it 'displays category', :vcr do

    within "#address_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :address_2, with: "1155 W 5th Ave, Denver, CO 80204"
      select "park", from: :category
      click_button 'Search'
    end

    expect(page).to have_content("Park")
    expect(page).to have_no_content("Cafe")
  end

  it 'has cafe as default category', :vcr do

    within "#address_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :address_2, with: "1155 W 5th Ave, Denver, CO 80204"

      click_button 'Search'
    end

    expect(page).to have_content("Cafe")
  end

  describe 'invalid search', :vcr do
    it 'redirect to dashboard and flash error message when emtpy address input' do
      within "#address_search" do
        fill_in :address_1, with: ''
        fill_in :address_2, with: ''
        click_button 'Search'
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Please fill out both address fields')

    end
  end

  describe 'no results search', :vcr do
    it 'redirect to dashboard and flash alert message when no results found', :vcr do
      within "#address_search" do
        fill_in :address_1, with: '123 st'
        fill_in :address_2, with: '249 st'
        click_button 'Search'
      end
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('No midpoints found-please try different addresses')
    end
  end


  it 'has a form to update category', :vcr do

    within "#address_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :address_2, with: "1155 W 5th Ave, Denver, CO 80204"
      select "park", from: :category
      click_button 'Search'
    end

    select "bar", from: :category
    click_button 'Update Category'

    expect(current_path).to eq('/dashboard/results')
    expect(page).to have_content("Bar")
    expect(page).to have_no_content("Park")
  end

  it 'has a map', :vcr do

    within "#address_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :address_2, with: "1155 W 5th Ave, Denver, CO 80204"
      select "cafe", from: :category
      click_button 'Search'
    end

    expect(page).to have_css('#map')
  end

  it 'has a list of locations', :vcr do

    within "#address_search" do
      fill_in :address_1, with: "2300 Steele St, Denver, CO 80205"
      fill_in :address_2, with: "1155 W 5th Ave, Denver, CO 80204"
      select "restaurant", from: :category
      click_button 'Search'
    end

    expect(page).to have_css('#locations')
  end
end
