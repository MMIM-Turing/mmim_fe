class SessionsController < ApplicationController

  def new; end
  
  def create
    user = UsersFacade.find_or_create_user(auth_params(request.env['omniauth.auth']))
  	session[:user_email] = user.email
  	redirect_to dashboard_path
    flash[:success] = 'You have successfully logged in!'

  end

  def destroy 
  	session.destroy 
  	redirect_to root_path
  	flash[:success] = 'You have successfully logged out!'
  end 


private 
  def auth_params(params)
    {name: params[:info][:name], email: params[:info][:email]}
  end
end