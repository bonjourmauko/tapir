class AddServiceToSource < ActiveRecord::Migration
  def self.up
    add_column :sources, :service, :string
  end

  def self.down
    remove_column :sources, :service
  end
end
