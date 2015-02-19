class AddIndicesToUser < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
    add_index :users, [:provider, :uid], unique: true
  end
end
