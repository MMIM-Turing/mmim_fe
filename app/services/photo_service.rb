class PhotoService
  def self.get_url(photo_reference)
  	response = Faraday.get("https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&photo_reference=#{photo_reference}&key=#{ENV['google_maps_api_key']}") 
  	response.headers[:location]
  end
end