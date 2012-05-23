class AddColumnsToCopies < ActiveRecord::Migration
  def change
    add_column :copies, 'dewey',:string,:limit=>10
    add_column :copies, 'cutter',:string,:limit=>4    
  end
end
