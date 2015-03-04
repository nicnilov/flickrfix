class HomeController < ApplicationController
  def index
    if current_flickr_account.present?
      flickr_account = FlickrAccount.find(current_flickr_account)
      flickr_api = flickrapi(flickr_account.oauth_token, flickr_account.oauth_token_secret)
      @albums = flickr_api.list_albums
    end
  end
end
