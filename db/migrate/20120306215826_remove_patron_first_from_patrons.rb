class RemovePatronFirstFromPatrons < ActiveRecord::Migration
  def up
    remove_column :patrons, :patron_first
  end

  def down
    add_column :patrons, :patron_first, :string
  end
end
