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
    @price_rating = price_conv(attributes[:price_level]) 
  end

  def price_conv(level=nil)
    return '$' if level == 1
    return '$$' if level == 2
    return '$$$' if level == 3
    return '$$$$' if level == 4
    return 'N/a' if level==nil 
  end
end
