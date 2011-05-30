class AddExternalIdToIllustration < ActiveRecord::Migration
  def self.up
    add_column :illustrations, :external_id, :string
    add_column :illustrations, :service, :string
  end

  def self.down
    remove_column :illustrations, :service
    remove_column :illustrations, :external_id
  end
end
