class ResultsController < ApplicationController
  before_action :require_address

  def index
    # @locations = LocationsFacade.top_5(search_params)
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
end
