class AddPremasterUpdatedAtToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :premaster_updated_at, :datetime
  end

  def self.down
    remove_column :books, :premaster_updated_at
  end
end
