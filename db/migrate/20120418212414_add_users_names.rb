class AddUsersNames < ActiveRecord::Migration
  def up
    add_column 'users','first',:string
    add_column 'users','last',:string
  end

  def down
    
  end
end
