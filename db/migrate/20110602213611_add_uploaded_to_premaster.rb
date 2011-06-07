class AddUploadedToPremaster < ActiveRecord::Migration
  def self.up
    add_column :premasters, :uploaded, :boolean
  end

  def self.down
    remove_column :premasters, :uploaded
  end
end
