class AddColumnsForLogicalDeleting < ActiveRecord::Migration
  def up
    add_column :books, :deleted, :boolean, :default=>false, :null=>false
    add_column :copies, :deleted, :boolean, :default=>false, :null=>false    
    add_column :checkouts, :deleted, :boolean, :default=>false, :null=>false
    add_column :users, :deleted, :boolean, :default=>false, :null=>false    
  end

  def down
    remove_column :books, :deleted
    remove_column :copies, :deleted
    remove_column :checkouts, :deleted
    remove_column :users, :deleted
  end
end
