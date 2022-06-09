require 'rails_helper'

RSpec.describe 'login page' do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google]
    # configured at bottom of rails_helper
  end
  it 'has a link to login with google and redirects to dashboard' do
    data = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_or_create_user).and_return(data)
    allow(MeetingsFacade).to receive(:get_meetings).and_return([])
    allow(BackendService).to receive(:get_meetings).and_return({ data: [] })
    allow_any_instance_of(DashboardController).to receive(:suggested_meetings).and_return([])
    visit '/login'

    click_on 'Log in with Google'

    expect(current_path).to eq dashboard_path
    expect(page).to_not have_link('Login')
    expect(page).to have_content("someone's Dashboard")
    # test user's name configured is someone
    expect(page).to have_content('You have successfully logged in!
')
  end
end
