class AddResourceIdToSource < ActiveRecord::Migration
  def self.up
    add_column :sources, :resource_id, :string
  end

  def self.down
    remove_column :sources, :resource_id
  end
end
