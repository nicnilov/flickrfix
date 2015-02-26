class FlickrAccount < ActiveRecord::Base
  belongs_to :user

  validates_presence_of [:username, :nsid, :oauth_token, :oauth_token_secret]
  validates_uniqueness_of :username

  def self.from_flickr_user_info(user_info, oauth_token, oauth_token_secret)
    FlickrAccount.create({
      username: user_info['person']['username']['_content'],
      realname: user_info['person']['realname']['_content'],
      nsid: user_info['person']['nsid'],
      icon_farm: user_info['person']['iconfarm'],
      icon_server: Integer(user_info['person']['iconserver']),
      oauth_token: oauth_token,
      oauth_token_secret: oauth_token_secret,
    })
  end
end
