class AddAccessionConstraint < ActiveRecord::Migration
  def up
    add_index :copies, [:accession], :unique => true
  end

  def down
  end
end
