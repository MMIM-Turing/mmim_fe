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

  describe 'map card', :vcr do
    it 'displays a map' do
      click_button 'Search'

      expect(page).to have_css('#map')
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
    end
  end
end
