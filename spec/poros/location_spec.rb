require 'rails_helper'

RSpec.describe Location do
  it 'exists' do
    attributes = {
                  name: "Ben & Jerry's",
                  place_id: "XXX1",
                  address: "123 st, city, state, 50001",
                  lat: "35.04443068881643",
                  lng: "-85.30914752416172",
                  rating: "4.1",
                  image_url: "https://iili.io/XDFtwX.jpg",
                  price_rating: "$"

    }

    location = Location.new(attributes)

    expect(location).to be_a Location
    expect(location.name).to be_a String
    expect(location.place_id).to be_a String
    expect(location.address).to be_a String
    expect(location.longitude).to be_a String
    expect(location.latitude).to be_a String
    expect(location.rating).to be_a String
    expect(location.image_url).to be_a String
    expect(location.price_rating).to be_a String
  end
end
