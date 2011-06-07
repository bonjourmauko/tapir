class CreatePremasters < ActiveRecord::Migration
  def self.up
    create_table :premasters do |t|
      t.string :guid

      t.timestamps
    end
  end

  def self.down
    drop_table :premasters
  end
end
