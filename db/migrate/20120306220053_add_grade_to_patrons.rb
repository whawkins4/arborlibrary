class AddGradeToPatrons < ActiveRecord::Migration
  def change
    add_column :patrons, :grade, :string
  end
end
