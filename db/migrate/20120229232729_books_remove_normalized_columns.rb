class BooksRemoveNormalizedColumns < ActiveRecord::Migration
  def up
    remove_column :books, :pub_name
    remove_column :books, :pub_place
    remove_column :books, :auth_last
    remove_column :books, :auth_middle
    remove_column :books, :auth_first
  end

  def down
  end
end
