class User < ActiveRecord::Base
  def self.from_oauth(auth)
    Rails.logger.info(auth.to_yaml)
    user = where(provider: auth.provider, uid: auth.uid).first || where(email: auth.email).first || User.create
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.save!
    user
  end
end
