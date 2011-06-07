class CreatePremasterPackets < ActiveRecord::Migration
  def self.up
    create_table :premaster_packets do |t|
      t.string :premaster_guid
      t.string :client_timestamp
      t.integer :position
      t.integer :length
      t.text :chunk

      t.timestamps
    end
  end

  def self.down
    drop_table :premaster_packets
  end
end
