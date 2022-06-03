class ResultsController < ApplicationController

  def index
  end

  def create
    #some call to backend
    redirect_to '/results'
  end
end
