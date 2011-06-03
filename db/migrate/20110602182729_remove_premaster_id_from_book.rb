class RemovePremasterIdFromBook < ActiveRecord::Migration
  def self.up
    remove_column :books, :premaster_id
  end

  def self.down
    add_column :books, :premaster_id, :string
  end
end
