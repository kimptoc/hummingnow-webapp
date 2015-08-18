class SessionController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    flash[:notice] = "Logged In !!"
    redirect_to root_path
  end

  def auth_hash
  	request.env['omniauth.auth']
  end	

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully Logged Out !!"
    redirect_to root_path
  end
end