class AddBookIdToSource < ActiveRecord::Migration
  def self.up
    add_column :sources, :book_id, :integer
  end

  def self.down
    remove_column :sources, :book_id
  end
end
