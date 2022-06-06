class Dashboard::UserResultsController < ApplicationController
  before_action :require_address, except: :update
  before_action :default_category

  def index
    @locations = LocationsFacade.address_location_search(search_params)
    @category = search_params[:category]
    @map_info = LocationsFacade.map_info(@locations)
  end

  private

  def search_params
    params.permit(:address_1, :user_b_email, :category)
  end

  def require_address
    if search_params[:address_1].empty? || search_params[:user_b_email].empty?
      flash[:alert] = "Please fill out both address fields"
      redirect_to '/dashboard'
    else
    end
  end

  def default_category
    if search_params[:category].empty?
      params[:category] = "cafe"
    else
    end
  end
end
