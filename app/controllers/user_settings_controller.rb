class UserSettingsController < ApplicationController

  #before_filter :authenticate_user!
  before_filter :check_auth_no_nickname

  respond_to :json

  def index
    results = current_user.user_settings
    respond_with results
  end

  def show
    #key = params[:key]
    #nickname = params[:nickname]
    #results = current_user.user_settings.where("key = ?", key)
    #auth_id = current_user.authentications.where(:nickname => nickname).first if nickname.present?
    #results = results.where(:authentication_id => auth_id) if auth_id.present?
    result = current_user.user_settings.find(params[:id])
    respond_with result
  end

    # GET /called_numbers/new
    # GET /called_numbers/new.xml
    def new
      result = UserSetting.new
      result.user = current_user

      respond_with result
    end

    # GET /called_numbers/1/edit
    def edit
      result = current_user.user_settings.find(params[:id])
      respond_with result
    end

  def get_params_user_setting
    us = params[:user_setting]
    us_new = {}
    us.each_entry do |key,value|
      us_new[key] = value.to_s
    end
    us_new
  end

  # POST /called_numbers
    # POST /called_numbers.xml
    def create
      results = current_user.user_settings.where(:key => params[:key])
      if results.empty?
        result = UserSetting.new(get_params_user_setting())
      else
        result = results[0]
      end
      result.user = current_user

      result.save!

      respond_with result

    end

    # PUT /players/1
    # PUT /players/1.xml
    def update
      result = current_user.user_settings.find(params[:id])

      result.update_attributes(get_params_user_setting())

      respond_with result

    end

    # DELETE /players/1
    # DELETE /players/1.xml
    def destroy
      result = current_user.user_settings.find(params[:id])
      result.destroy

      respond_with result
    end
end
