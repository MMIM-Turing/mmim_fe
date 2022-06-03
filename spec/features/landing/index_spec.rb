require 'rails_helper'


RSpec.describe 'landing page' do 
  it 'has a link to login and redirects to a login page' do 
  	visit root_path

  	click_on 'Login'

  	expect(current_path).to eq('/login')
  end
end