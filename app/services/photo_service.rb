class PhotoService
  def self.get_url(photo_reference)
  	response = Faraday.get("https://maps.googleapis.com/maps/api/place/photo?maxwidth=200&photo_reference=#{photo_reference}&key=#{ENV['google_maps_api_key']}") 
   #  response = Faraday.get("https://maps.googleapis.com/maps/api/place/photo") do |faraday|
  	#      faraday.params['maxwidth'] = 200
  	#      faraday.params['photo_reference'] = photo_reference
  	#      faraday.params['key'] = ENV.fetch('google_maps_api_key', nil)
  	# end
  	response.headers[:location]
  end
end