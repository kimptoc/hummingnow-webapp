class HomeController < ApplicationController

  #before_filter :authenticate_user!, :except => [:public, :search, :about]

  before_filter :check_auth, :get_lists , :except => [:user, :public, :search, :about]
  before_filter :get_settings

  before_filter :get_avatar, :only => [:user, :public, :search, :about]

  around_filter :error_catcher

  def index
    @topbar_home_active = 'active'
  end

  def mentions
    @topbar_mentions_active = 'active'
  end

  def mine
    @topbar_mine_active = 'active'
  end

  def public
    @topbar_public_active = 'active'
  end

  def user
    @screen_name = params[:screen_name]
  end

  def list
    @topbar_lists_active = 'active'
    @list_id = params[:list_id]
  end

  def dm
    @topbar_dm_active = 'active'
  end

  def search
    @topbar_search_active = 'active'
    @query = params[:query]
  end

  def about
    @topbar_about_active = 'active'
    @total_users = User.count
    @num_users_joined_today = User.where("created_at > ?",1.day.ago).count
    @num_users_joined_last_hour = User.where("created_at > ?",1.hour.ago).count
    @num_users_signed_in_today = User.where("updated_at > ?",1.day.ago).count
    @num_users_signed_in_last_hour = User.where("updated_at > ?",1.hour.ago).count
    @num_users = User.count
    @num_auths = Authentication.count
    if user_signed_in? and @nickname.present? and @nickname == "kimptoc"
      @user_list = Authentication.select([:nickname, :avatar_url, :created_at]).order(:created_at).reverse[0..20]
      @user_today_list = Authentication.select([:nickname, :avatar_url, "users.updated_at"]).
          joins(:user).
          order("users.updated_at").reverse[0..20]
    end
  end

  def handle_error(e)
    Rails.logger.error "Error trapped by error_catcher: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    if current_user.present? and current_user.authentications.present?
      current_user.authentications.each do |auth|
        auth.delete
      end
    end
    sign_out
  end

  def get_settings
    @user_settings = []
    if current_user
      @user_settings = current_user.user_settings
    end
  end

  def get_avatar
    @nickname = params[:nickname]
    if current_user
      auths = current_user.authentications.where(:nickname => @nickname)
      if auths.present? and auths.count > 0
        @avatar_url = auths.first.avatar_url
      end
    end
  end

  def get_lists
    if @lists.nil?
      @lists = []
      begin
        @lists = current_user.lists(@nickname) if current_user.present?
      rescue Exception => e
        handle_error(e)
      end
      Rails.logger.debug "get_lists called:lists:#{@lists.size}"
    end
  end

  #not sure if this is being called...
  def error_catcher
    begin
      user_nickname = @nickname
      #user_nickname = current_authentication.nickname if current_authentication.present?
      Rails.logger.info "Processing request for user:#{user_nickname}"
      yield
    rescue Exception => e
      handle_error(e)
      render :status => 500
    end
  end

end
