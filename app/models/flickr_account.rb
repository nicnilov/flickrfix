class FlickrAccount < ActiveRecord::Base
  validates_uniqueness_of :username
end
