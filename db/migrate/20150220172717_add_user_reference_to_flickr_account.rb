class AddUserReferenceToFlickrAccount < ActiveRecord::Migration
  def change
    add_reference :flickr_accounts, :user, index: true
  end
end
