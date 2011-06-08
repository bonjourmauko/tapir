class AddCoverColumnsToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :cover_original_id, :string
    add_column :images, :width, :integer
    add_column :images, :height, :integer
  end

  def self.down
    remove_column :images, :height
    remove_column :images, :width
    remove_column :images, :cover_original_id
  end
end
