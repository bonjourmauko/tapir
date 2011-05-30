class CreateIllustrations < ActiveRecord::Migration
  def self.up
    create_table :illustrations do |t|
      t.string :original_url
      t.integer :book_id

      t.timestamps
    end
  end

  def self.down
    drop_table :illustrations
  end
end
