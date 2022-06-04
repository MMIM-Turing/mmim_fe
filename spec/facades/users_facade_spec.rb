require 'rails_helper'

RSpec.describe UsersFacade do
  it 'receives users data and creates user poro' do
    data = JSON.parse(File.read('spec/fixtures/user.json'), symbolize_names: true)
    allow(UsersService).to receive(:find_or_create_user).and_return(data)

    results = UsersFacade.find_or_create_user({ name: 'someone', email: 'sample@email.com' })

    expect(results).to be_a User
    expect(results.name).to eq('someone')
    expect(results.email).to eq('sample@email.com')
    expect(results.address).to be(nil)
  end
end
