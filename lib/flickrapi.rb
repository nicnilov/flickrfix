require('flickrapi/auth')

class FlickrApi
  include Auth

  FLICKR_API_ROOT = 'https://api.flickr.com/services/rest'

  def initialize(options = {})
    @consumer_key = options.fetch(:consumer_key) # mandatory parameter
    @consumer_secret = options.fetch(:consumer_secret) # mandatory parameter
    @oauth_token = options[:oauth_token]
    @oauth_token_secret = options[:oauth_token_secret]
    @oauth_callback = options[:oauth_callback]
    @debug_output = options[:debug_output]
  end

  def list_albums
    response = api_request(:get, {method: 'flickr.photosets.getList'})
    response['photosets']['photoset']
  end

  def list_album_videos(album_id)
    response = api_request(:get, {method: 'flickr.photosets.getPhotos', photoset_id: album_id, media: 'videos',
                                  extras: 'date_upload,date_taken,url_t'})
    response['photoset']['photo']
  end

  def set_modified_date(photo_id, timestamp)
    response = api_request(:post, {method: 'flickr.photos.setDates', photo_id: photo_id,
                                   date_taken: Time.at(timestamp).strftime('%Y-%m-%d %H:%M:%S'),
                                   date_taken_granularity: 0})
  end

  def get_user_info(user_nsid)
    response = api_request(:get, {method: 'flickr.people.getInfo', user_id: user_nsid})
    # response['photosets']['photoset']
  end

  private
  def api_request(method, params = {})
    params = sign(method, FLICKR_API_ROOT, { format: :json, nojsoncallback: 1 }.merge(params))
    response = HTTParty.send(method, FLICKR_API_ROOT, debug_output: debug_output,
                             method == :get ? :query : :body =>  params)
  end
end
