class RemovePatronLastFromPatrons < ActiveRecord::Migration
  def up
    remove_column :patrons, :patron_last
  end

  def down
    add_column :patrons, :patron_last, :string
  end
end
