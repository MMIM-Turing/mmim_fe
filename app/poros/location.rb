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
    @longitude = attributes[:lng]
    @latitude = attributes[:lat]
    @rating = attributes[:rating]
    @image_url = attributes[:image_url]
    @price_rating = attributes[:price_rating]
  end
end
