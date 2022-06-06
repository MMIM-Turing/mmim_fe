class DashboardController < ApplicationController
  before_action :require_user
  before_action :require_address_params, only: :update 

  def show
    # meeting = MeetingsFacade
    # locations = LocationsFacade.find_midppoints(address_params)
  end

  def edit; end

  def update
    updated_user = UsersFacade.create_or_update_address(info_params)
    redirect_to dashboard_path
  end

  def new_meeting
    # suggested_meeting = MeetingsFacade.suggested_meeting(new_meeting_params)
    redirect_to '/dashboard'
  end

  private

  def address_params
    params[:street] + ', ' + params[:city] + ', ' + params[:state] + ' ' + params[:zipcode]
  end

  def require_address_params
    if params[:street].empty? || params[:city].empty?  || params[:state].empty? || params[:zipcode].empty?
      flash[:alert] = 'Please fill out all required area'
      if params[:commit] == "Update Default Address"
        redirect_to '/dashboard/address?type=update'
      else 
        redirect_to '/dashboard/address?type=new'
      end
    end
  end
  def info_params
    { email: current_user.email, address: address_params }
  end

  def new_meeting_params
    { user_a_email: params[:user_a_email], user_b_email: params[:user_b_email], place_ids: params[:place_ids] }
  end
end
