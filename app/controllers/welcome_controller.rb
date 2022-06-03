class WelcomeController < ApplicationController 
  def index 
  end

  def results 
  	@locations = LocationsFacade.find_midppoints(address_params)
  end


  private
  def address_params
  	params.permit(:add_1, :add_2, :category)
  end
end