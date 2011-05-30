class AddMasterIdToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :master_id, :string
  end

  def self.down
    remove_column :books, :master_id
  end
end
