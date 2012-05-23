class RemoveUsersName < ActiveRecord::Migration
  def up
    remove_column 'users','name'
  end

  def down
  end
end
