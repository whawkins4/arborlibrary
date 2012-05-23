class RemovePatronClassFromPatrons < ActiveRecord::Migration
  def up
    remove_column :patrons, :patron_class
  end

  def down
    add_column :patrons, :patron_class, :string
  end
end
