class CreateCopiesDeaccessioned < ActiveRecord::Migration
  def up
        add_column :copies, :deaccessioned, :boolean, :default=>false, :null=>false
  end

  def down
    remove_column :copies, :deaccessioned
  end
end
