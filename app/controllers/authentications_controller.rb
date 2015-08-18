class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user

    if current_user
        auths = @authentications
        if auths.present? and auths.count > 0
          @nickname = auths.first.nickname
          @avatar_url = auths.first.avatar_url
        end
    end

  end

  def create
    #render :text => request.env["omniauth.auth"].to_yaml
    #return

    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      Rails.logger.debug "Existing user signed in:#{authentication.nickname}"
      flash[:notice] = "Signed in successfully."
      authentication.user.remember_me!
      #set_current_authentication(authentication.nickname)
      #session[:current_authentication] = authentication.nickname
      sign_in authentication.user
      redirect_to :controller => :home, :action => :index, :nickname => authentication.nickname
    elsif current_user
      authentication = current_user.apply_omniauth(omniauth)
      Rails.logger.debug "Existing user, new twitter connection:#{authentication.nickname}"
      flash[:notice] = "Authentication successful."
      current_user.remember_me!
      current_user.save!
      #set_current_authentication(authentication.nickname)
      #session[:current_authentication] = authentication.nickname
      redirect_to :controller => :home, :action => :index, :nickname => authentication.nickname
    else
      # user = User.find_or_create_by_email(:email => omniauth['info']['nickname'])
      user = User.first_or_create(:email => omniauth['info']['nickname'], password:  Devise.friendly_token[0,20])
      authentication = user.apply_omniauth(omniauth)
      Rails.logger.debug "New user:#{authentication.nickname}"
      user.remember_me!
      user.save!
      flash[:notice] = "Signed in successfully."
      #set_current_authentication(authentication.nickname)
      #session[:current_authentication] = authentication.nickname
      sign_in user
      redirect_to :controller => :home, :action => :index, :nickname => authentication.nickname
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

end
