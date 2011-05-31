class AddFreeToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :free, :boolean
  end

  def self.down
    remove_column :books, :free
  end
end
