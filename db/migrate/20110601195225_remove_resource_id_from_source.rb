class RemoveResourceIdFromSource < ActiveRecord::Migration
  def self.up
    remove_column :sources, :resource_id
  end

  def self.down
    add_column :sources, :resource_id, :integer
  end
end
