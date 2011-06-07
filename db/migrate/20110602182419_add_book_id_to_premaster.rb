class AddBookIdToPremaster < ActiveRecord::Migration
  def self.up
    add_column :premasters, :book_id, :integer
  end

  def self.down
    remove_column :premasters, :book_id
  end
end
