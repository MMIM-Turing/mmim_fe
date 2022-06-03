class ApplicationController < ActionController::Base
  helper_method :current_session

  def current_session 
    session[:authenticated]
  end
end
