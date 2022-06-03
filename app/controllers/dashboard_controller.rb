class DashboardController < ApplicationController 
  before_action :current_session

  def show 
  	meeting = MeetingsFacade
  	locations = LocationsFacade.find_midppoints(address_params)
  def 


end