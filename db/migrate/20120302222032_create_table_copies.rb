class CreateTableCopies < ActiveRecord::Migration
  def up
    return
  end

  def down
    drop_table :copies
  end
end
