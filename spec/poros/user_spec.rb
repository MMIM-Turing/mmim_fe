require 'rails_helper'

RSpec.describe User do
  it 'can be created with name, email, and address can be nil or exit' do
    data = { name: 'someone', email: 'sample@email.com' }
    data2 = { name: 'someone', email: 'sample@email.com', address: 'address' }

    user = User.new(data)
    user2 = User.new(data2)
    expect(user).to be_a(User)
    expect(user.name).to eq('someone')
    expect(user.email).to eq('sample@email.com')
    expect(user.address).to be(nil)
    expect(user2).to be_a(User)
    expect(user2.address).to eq('address')
  end
end
