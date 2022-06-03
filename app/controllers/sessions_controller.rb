class SessionsController < ApplicationController
before_action :current_user

  def create
    user = UsersFacade.find_user(request.env['omniauth.auth'])
  	if user
  	  session[:authenticated] = 'authenticated'
  	  redirect_to dashboard_path 
  	 else 
  	 	redirect_to root_path
  	 	flash[:error] = 'Unable to log in with Google Credentials!'
  	end
  end

  def destroy 
  	session.destroy 
  	redirect_to welcome_page
  	flash[:success] = 'You have successfully logged out!'
  end 


end