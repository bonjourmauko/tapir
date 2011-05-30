class RemoveServiceFromIllustration < ActiveRecord::Migration
  def self.up
    remove_column :illustrations, :service
  end

  def self.down
    add_column :illustrations, :service, :string
  end
end
