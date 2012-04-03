class SessionsController < ApplicationController
  def new
  end

  def create
    # raise request.env["omniauth.auth"].to_yaml
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    # raise request.env["omniauth.error"].to_yaml
    redirect_to root_url, alert: "Authentication failed, please try again."
  end
end
