class HomeController < ApplicationController
  def index
    if current_flickr_account.present?
      flickr_account = FlickrAccount.find(current_flickr_account)
      flickr_api = flickrapi(flickr_account.oauth_token, flickr_account.oauth_token_secret)
      @albums = flickr_api.list_albums.collect do |album|
        if album['videos'].to_i > 0
          album['background_image'] = "https://farm#{album['farm']}.staticflickr.com/#{album['server']}/#{album['primary']}_#{album['secret']}_n.jpg"
          album['stats'] = "#{album['videos']} videos"
          album
        end
      end.compact
    end
  end
end
