require 'rails_helper'

RSpec.describe 'results page' do
  before :each do
    visit '/'
    fill_in :address_1, with: "123 st, city, state, 50001"
    fill_in :address_2, with: "124 st, city, state, 50003"
  end
  describe 'map card' do
    xit 'displays a map' do
      click_button 'Search'

      expect(page).to have_xpath("//a")
    end
  end

  describe 'result list card' do
    context 'category' do
      it 'displays category' do
        fill_in :category, with: "gym"
        click_button 'Search'

        expect(page).to have_content("Gym")
        expect(page).to have_no_content("Coffee shop")
      end

      it 'displays coffee shop as the default category' do
        click_button 'Search'
        #note that we didn't fill out :category in the before block
        expect(page).to have_content("Coffee shop")
      end


      it 'has a form to update category' do
        click_button 'Search'
        fill_in :category, with: "bar"
        click_button 'Update Category'

        expect(current_path).to eq('/results')
        expect(page).to have_content("Bar")
        expect(page).to have_no_content("Coffee shop")
      end
    end
  end
end
