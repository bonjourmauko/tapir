class AddPayPalUsernameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :paypal_username, :string
  end

  def self.down
    remove_column :users, :paypal_username
  end
end
