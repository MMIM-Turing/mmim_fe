class DashboardController < ApplicationController
  before_action :require_user
  before_action :require_address_params, only: :update
  before_action :require_checkbox, only: :new_meeting

  def show
    @suggested_meetings = suggested_meetings
    @accepted_meetings = MeetingsFacade.get_meetings({ email: current_user.email })
  end

  def edit; end

  def update
    updated_user = UsersFacade.create_or_update_address(info_params)
    redirect_to dashboard_path
  end

  def accept_meeting
    MeetingsFacade.create_meeting(accepted_meeting_params)
    Rails.cache.delete(suggested_meeting_key)
    redirect_to dashboard_path
  end

  def new_meeting
    suggested_locations
    redirect_to dashboard_path
  end

  private

  def address_params
    params[:street] + ', ' + params[:city] + ', ' + params[:state] + ' ' + params[:zipcode]
  end

  def require_address_params
    if params[:street].empty? || params[:city].empty? || params[:state].empty? || params[:zipcode].empty?
      flash[:alert] = 'Please fill out all required area'
      if params[:commit] == 'Update Default Address'
        redirect_to '/dashboard/address?type=update'
      else
        redirect_to '/dashboard/address?type=new'
      end
    end
  end

  def info_params
    { email: current_user.email, address: address_params }
  end

  def accepted_meeting_params
    { host_email: params[:host_email], guest_email: params[:guest_email], location_name: params[:location_name],
      location_address: params[:location_address] }
  end

  def suggested_meeting_key
    info = { host_email: params[:host_email], guest_email: params[:guest_email], place_ids: params[:place_ids] }
    info.values.join.delete(' ')
  end

  def new_meeting_params
    { host_email: params[:user_a_email], guest_email: params[:user_b_email], place_ids: params[:place_ids] }
  end

  def params_from_user_results_controller
    { 'address_1' => params[:address_1], 'user_b_email' => params[:user_b_email], 'category' => params[:category] }
  end

  def suggested_meetings
    if Rails.cache.instance_variable_get(:@data)
      keys = Rails.cache.instance_variable_get(:@data).keys.find_all { |k| k.include?(current_user.email) }
      keys = keys.find_all { |k| !k.include?('user_b_email') }
      keys.map { |k| Rails.cache.read(k) }
    end
  end

  def suggested_locations
    all_locations = Rails.cache.read("locations - #{params_from_user_results_controller}")
    suggested_locations = all_locations.find_all do |location|
      new_meeting_params[:place_ids].include?(location.place_id)
    end
    Rails.cache.fetch(new_meeting_params.values.join.to_s) do
      meetings = MeetingsFacade.suggested_meeting({ locations: suggested_locations,
                                                    host_email: new_meeting_params[:host_email], guest_email: new_meeting_params[:guest_email] })
    end
  end

  def require_checkbox
    if params[:place_ids].nil?
      flash[:alert] = 'Please select at least one location'
      render :show
    end
  end
end
