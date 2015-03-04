require_dependency('flickrapi')

class FlickrAccountsController < ApplicationController
  def new
    response = flickrapi.request_token
    if response['oauth_token'] && response['oauth_token_secret']
      session[:oauth_token] = response['oauth_token']
      session[:oauth_token_secret] = response['oauth_token_secret']
      redirect_to flickrapi.user_authorization_url
    else
      redirect_to home_path
    end
  end

  def callback
    redirect_to home_path unless params['oauth_verifier'] #todo better handling

    oauth_token = session.delete(:oauth_token)
    oauth_token_secret = session.delete(:oauth_token_secret)

    response = flickrapi(oauth_token, oauth_token_secret).access_token(params['oauth_verifier'])
    redirect_to home_path unless response['user_nsid'].present? #todo better handling

    user_info = flickrapi.get_user_info(URI.unescape(response['user_nsid']))
    redirect_to home_path unless user_info['person'].present? #todo better handling

    current_user.flickr_accounts << FlickrAccount.from_flickr_user_info(user_info, flickrapi.oauth_token, flickrapi.oauth_token_secret)

    redirect_to home_path
  end
end
