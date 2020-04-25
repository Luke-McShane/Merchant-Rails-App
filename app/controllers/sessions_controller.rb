class SessionsController < ApplicationController
    def create
        auth_data = request.env["omniauth.auth"]
        #puts "AUTH_DATA = #{auth_data} END"
        puts "PROVIDER:  #{auth_data["provider"]}"
        puts "UID:  #{auth_data["uid"]}"
        puts "NAME:  #{auth_data["info"]["name"]}"
        #@user = User.find_or_create_by_auth(request.env["omniauth.auth"])
        @user = User.where(:provider => auth_data["provider"], :uid => auth_data["uid"], :name => auth_data["info"]["name"]).first_or_create(auth_data["info"]["name"])
        session[:user_id] = @user_id
        redirect_to products_path, notice: "Logged in as #{@user.name}"
    end

    def googleAuth
        # @user = User.find_or_create_by_auth(request.env["omniauth.auth"])
        # session[:user_id] = @user_id
        # redirect_to products_path, notice: "Logged in as #{@user.name}"
        # Get access tokens from the google server
        access_token = request.env["omniauth.auth"]
        user = User.from_omniauth(access_token)
        log_in(user)
        # Access_token is used to authenticate request made from the rails application to the google server
        user.google_token = access_token.credentials.token
        # Refresh_token to request new access_token
        # Note: Refresh_token is only sent once during the first request
        refresh_token = access_token.credentials.refresh_token
        user.google_refresh_token = refresh_token if refresh_token.present?
        user.save
        redirect_to root_path
      end
end
