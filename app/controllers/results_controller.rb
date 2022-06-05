class ResultsController < ApplicationController
  before_action :require_address
  before_action :default_category

  def index
    @locations = LocationsFacade.address_location_search(search_params)
    @category = search_params[:category]
  end


  private

  def search_params
    params.permit(:address_1, :address_2, :category)
  end

  def require_address
    if search_params[:address_1].empty? || search_params[:address_2].empty?
      flash[:alert] = "Please fill out both address fields"
      redirect_to '/'
    else
    end
  end

  def default_category
    if search_params[:category].empty?
      params[:category] = "coffee shop"
    else
    end
  end
end
