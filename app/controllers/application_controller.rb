class ApplicationController < ActionController::Base
  helper_mathod :current_session

  def current_session 
    session[:authenticated]
  end
end
