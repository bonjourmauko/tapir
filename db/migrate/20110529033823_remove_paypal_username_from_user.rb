class RemovePaypalUsernameFromUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :paypal_username
  end

  def self.down
    add_column :users, :paypal_username, :string
  end
end
