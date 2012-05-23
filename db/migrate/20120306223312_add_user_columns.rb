class AddUserColumns < ActiveRecord::Migration
  def up
    add_column :users, :grade, :string
    add_column :users, :library_card, :string
    
  end

  def down
    remove_column :users,:grade
    remove_column :users, :library_card
  end
end
