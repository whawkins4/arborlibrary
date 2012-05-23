class RemovePatronGradeFromPatrons < ActiveRecord::Migration
  def up
    remove_column :patrons, :patron_grade
  end

  def down
    add_column :patrons, :patron_grade, :string
  end
end
