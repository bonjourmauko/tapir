class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|
      t.integer :resource_id
      t.boolean :collection

      t.timestamps
    end
  end

  def self.down
    drop_table :sources
  end
end
