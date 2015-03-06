class SessionsController < ApplicationController

  skip_before_filter :authenticated?

  def create
    user = User.from_oauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
