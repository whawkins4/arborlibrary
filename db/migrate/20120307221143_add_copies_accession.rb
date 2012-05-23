class AddCopiesAccession < ActiveRecord::Migration
  def up
    create_table :copies do |t|
      t.integer :book_id
      t.string :catalog_date
      t.string :copy_number
      t.string :collection
      t.string :source
      t.timestamps
    end
    
    add_column :copies, :accession, :integer
  end

  def down
    remove_column :copies, :accession
  end
end
