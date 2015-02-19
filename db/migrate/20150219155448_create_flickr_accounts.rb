class CreateFlickrAccounts < ActiveRecord::Migration
  def change
    create_table :flickr_accounts do |t|
      t.string  :username
      t.string  :realname
      t.string  :nsid
      t.integer :icon_farm
      t.integer :icon_server
      t.string  :oauth_token
      t.string  :oauth_token_secret

      t.timestamps null: false
    end
    add_index :flickr_accounts, :username, unique: true
  end
end
