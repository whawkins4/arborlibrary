class RemoveLegacyBooksColumns < ActiveRecord::Migration
  def up
    remove_column :books, :dewey
    remove_column :books, :cutter
    remove_column :books, :accession  
    remove_column :books, :copy
    remove_column :books, :collection
    remove_column :books, :source    
  end

  def down
  end
end
