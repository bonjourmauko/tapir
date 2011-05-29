class AddPremasterId2ToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :premaster_id, :integer
  end

  def self.down
    remove_column :books, :premaster_id
  end
end
