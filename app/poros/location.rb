class Location
  attr_reader :name,
              :place_id,
              :address,
              :longitude,
              :latitude,
              :rating,
              :image_url,
              :price_rating

  def initialize(attributes)
    @name = attributes[:name]
    @place_id = attributes[:place_id]
    @address = attributes[:address]
    @longitude = attributes[:longitude]
    @latitude = attributes[:latitude]
    @rating = attributes[:rating]
    @image_url = attributes[:img_url]
    @price_rating = attributes[:price_rating]
  end
end
