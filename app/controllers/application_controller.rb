class ApplicationController < ActionController::Base
  # include ApplicationHelper
  helper_method :current_user

  def current_user
    @current_user ||= UsersFacade.find_or_create_user({ email: session[:user_email] }) if session[:user_email]
   end

  def require_user
    unless current_user
      redirect_to '/login'
      flash[:success] = 'Please log in to proceed!'
    end
  end
end

# module ApplicationHelper
#   def current_user
#     UsersFacade.find_or_create_user({ email: session[:user_email] }) if session[:user_email]
#   end
# end
