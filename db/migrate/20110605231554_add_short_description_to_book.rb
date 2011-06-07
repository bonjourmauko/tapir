class AddShortDescriptionToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :short_description, :text
  end

  def self.down
    remove_column :books, :short_description
  end
end
