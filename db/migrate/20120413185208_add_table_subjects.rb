class AddTableSubjects < ActiveRecord::Migration
  def up
    create_table :subjects do |t|
      t.string :subject, :null=>false
      t.integer :parent_id, :null=>true
    end
  end

  def down
    drop_table :subjects
  end
end
