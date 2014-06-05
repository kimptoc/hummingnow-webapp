class ApplicationController < ActionController::Base
  protect_from_forgery

  #def set_current_authentication(auth)
  #  Rails.logger.debug "Setting curr auth:#{auth.nickname}"
  #  session[:current_authentication] = auth
  #end

  #def current_authentication
  #  nicknick = session[:current_authentication] if session[:current_authentication].present?
  #  Rails.logger.debug "Getting curr auth:#{nicknick}"
  #  session[:current_authentication]
  #end

  def check_auth_no_nickname
    check_auth(false)
  end

  def check_auth(require_nickname = true)
    #return redirect_to :controller => "authentications" unless current_user
    return redirect_to :controller => "home", :action => "public" unless current_user
    if params[:nickname].present?
      @nickname = params[:nickname]
    end
    if require_nickname
      if @nickname.nil?
        auth = current_user.authentications.first
        if auth.present?
          Rails.logger.debug "no nickname, redirecting to first auth"
          redirect_to :controller => "home", :action => 'index', :nickname => auth.nickname
        else
          Rails.logger.debug "no nickname, no auths, redirecting to auth"
          #redirect_to :controller => 'authentications'
          sign_out
          redirect_to :controller => "home", :action => 'public'
        end
      else
        auths = current_user.authentications.where(:nickname => @nickname)
        if auths.present? and auths.count > 0
          @avatar_url = auths.first.avatar_url
        else
          if auth.present?
            Rails.logger.debug "invalid nickname, redirecting to first auth"
            redirect_to :controller => "home", :action => 'index', :nickname => auth.nickname
          else
            Rails.logger.debug "invalid nickname, no auths, redirecting to auth"
            #redirect_to :controller => 'authentications'
            sign_out
            redirect_to :controller => "home", :action => 'public'
          end
        end
      end
    end
  end

end
