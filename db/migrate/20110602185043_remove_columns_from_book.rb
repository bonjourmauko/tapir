class RemoveColumnsFromBook < ActiveRecord::Migration
  def self.up
    remove_column :books, :premaster_updated_at
    remove_column :books, :master_id
  end

  def self.down
    add_column :books, :master_id, :string
    add_column :books, :premaster_updated_at, :datetime
  end
end
