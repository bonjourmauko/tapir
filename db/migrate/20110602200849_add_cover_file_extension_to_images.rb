class AddCoverFileExtensionToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :cover_file_extension, :string
  end

  def self.down
    remove_column :images, :cover_file_extension
  end
end
