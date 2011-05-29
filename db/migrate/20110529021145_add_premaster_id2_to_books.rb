class AddPremasterId2ToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :premaster_id, :string
  end

  def self.down
    remove_column :books, :premaster_id
  end
end
