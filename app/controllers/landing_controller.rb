class LandingController < ApplicationController
  def index
  	@locations = [34.052235, -118.243683]
  # 	@locations = [
  #   ['Los Angeles', 34.052235, -118.243683],
  #   ['Santa Monica', 34.024212, -118.496475],
  #   ['Redondo Beach', 33.849182, -118.388405],
  #   ['Newport Beach', 33.628342, -117.927933],
  #   ['Long Beach', 33.770050, -118.193739]
  # ]
  end

end