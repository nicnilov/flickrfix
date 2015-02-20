class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_flickr_account
    if @current_flickr_account.present? && session[:flickr_account_id] == @current_flickr_account.id
      @current_flickr_account
    elsif current_user.present?
      @current_flickr_account = current_user.flickr_accounts.find_by_id(session[:flickr_account_id]) if session[:flickr_account_id].present?
      unless @current_flickr_account.present?
        @current_flickr_account = current_user.flickr_accounts.first
        session[:flickr_account_id] = @current_flickr_account.id if @current_flickr_account.present?
      end
    end
  end
  helper_method :current_flickr_account
end
