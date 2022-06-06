class ResultsController < ApplicationController
  before_action :require_address, except: :update
  before_action :default_category

  def index
    @locations = LocationsFacade.address_location_search(search_params)
    @category = search_params[:category]
    @map_info = LocationsFacade.map_info(@locations)
    if @locations == [] || @map_info == 'No results found'
      redirect_to root_path
      flash[:alert] = 'No midpoints found-please try different addresses'
    end
  end

  private

  def search_params
    params.permit(:address_1, :address_2, :category)
  end

  def require_address
    if search_params[:address_1].empty? || search_params[:address_2].empty?
      flash[:alert] = 'Please fill out both address fields'
      redirect_to '/'
    end
  end

  def default_category
    params[:category] = 'cafe' if search_params[:category].empty?
  end
end
