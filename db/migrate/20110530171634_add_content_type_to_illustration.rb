class AddContentTypeToIllustration < ActiveRecord::Migration
  def self.up
    add_column :illustrations, :content_type, :string
  end

  def self.down
    remove_column :illustrations, :content_type
  end
end
