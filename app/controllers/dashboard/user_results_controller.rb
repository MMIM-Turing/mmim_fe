class Dashboard::UserResultsController < ApplicationController
  before_action :require_address, except: :update
  before_action :default_category

  def index
    if current_user.email == search_params[:user_b_email]
      redirect_to dashboard_path
      flash[:alert] = "You've entered your own email. Please try again!"
    else
      @user_b = UsersFacade.find_user({ email: search_params[:user_b_email] })
      if @user_b == 'invalid email'
        redirect_to dashboard_path
        flash[:alert] = 'Invalid user email. Please try again!'
      elsif @user_b.address.nil?
        redirect_to dashboard_path
        flash[:alert] =
          "#{search_params[:user_b_email]} has not set a default address, please search by address instead!"
      else
        @locations = Rails.cache.fetch("locations - #{search_params}") do
          LocationsFacade.user_search(search_params)
        end
        @category = search_params[:category]
        @map_info = LocationsFacade.map_info(@locations)
        if @locations == [] || @map_info == 'No results found'
          redirect_to dashboard_path
          flash[:alert] = 'No midpoints found-please try different addresses'
        end
      end
    end
  end

  private

  def search_params
    params.permit(:address_1, :user_b_email, :category)
  end

  def require_address
    if search_params[:address_1].empty? || search_params[:user_b_email].empty?
      flash[:alert] = 'Please fill out both address fields'
      redirect_to '/dashboard'
    end
  end

  def default_category
    params[:category] = 'cafe' if search_params[:category].empty?
  end
end
