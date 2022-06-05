class DashboardController < ApplicationController
  before_action :require_user

  def show
    # meeting = MeetingsFacade
    # locations = LocationsFacade.find_midppoints(address_params)
  end

  def edit
  end 

  def update
    current_user = UsersFacade.create_or_update_address(info_params)
    redirect_to dashboard_path
  end

  private

  def address_params
    params[:street]+', '+params[:city]+', '+params[:state]+' '+params[:zipcode]
  end

  def info_params
    {email: current_user.email, address: address_params}
  end
end
