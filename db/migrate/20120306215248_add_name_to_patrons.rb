class AddNameToPatrons < ActiveRecord::Migration
  def change
    add_column :patrons, :name, :string
  end
end
