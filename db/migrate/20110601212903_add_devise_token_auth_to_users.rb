class AddDeviseTokenAuthToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.token_authenticatable
    end

  def self.down
  end
end
