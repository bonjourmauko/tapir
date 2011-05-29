class AddColumnsToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :title, :string
    add_column :books, :language, :string
    add_column :books, :paypal_username, :string
    add_column :books, :price, :decimal, :precision => 6, :scale => 2
  end

  def self.down
    remove_column :books, :price
    remove_column :books, :paypal_username
    remove_column :books, :language
    remove_column :books, :title
  end
end
