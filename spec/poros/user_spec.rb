require 'rails_helper'

RSpec.describe User do
  it 'can be created with name, email, and address can be nil or exit' do
    data = { name: 'someone', email: 'sample@email.com' }
    data2 = { name: 'someone', email: 'sample@email.com', address: '123 st, denver, co 80111' }

    user = User.new(data)
    user2 = User.new(data2)
    expect(user).to be_a(User)
    expect(user.name).to eq('someone')
    expect(user.email).to eq('sample@email.com')
    expect(user.address).to be(nil)
    expect(user2).to be_a(User)
    expect(user2.address).to eq('123 St, Denver, CO 80111')
  end

  describe 'instance methods' do 
    let(:user) {User.new({ name: 'someone1', email: 'sample1@email.com', address: '123 st, denver, co 80111' })}
    let(:user2) {User.new({ name: 'someone2', email: 'sample2@email.com', address: '123 st, denver, colorado 80111'})}
    it 'formats the address' do 
      expect(user.address).to eq('123 St, Denver, CO 80111')
    end

    it 'returns street address' do 
      expect(user.street_address).to eq('123 St')
    end

    it 'returns city address' do 
      expect(user.city).to eq('Denver')
    end

    it 'returns state or upcase state code' do 
      expect(user.state).to eq('CO')
      expect(user2.state).to eq('Colorado')
    end

    it 'returns zipcode' do 
      expect(user.zipcode).to eq('80111')
    end


  end
end
