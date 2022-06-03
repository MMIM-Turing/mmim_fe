class LandingController < ApplicationController
  def index
  	# @locations = [34.052235, -118.243683]
  	@locations = [
    ['average', 39.672481600, -105.0463299],
    ['Denver Bullets', 39.736680, -105.008170],
    ['Machine Gun Tours', 39.739420, -105.139040],
    ['The Shootist', 39.662628, -104.9954995],
    ['GMG', 39.655000, -105.083860],
    ['Triple J Armory', 39.56868, -105.00508]
  ]
  end

end